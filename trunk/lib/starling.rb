require 'fastthread'

$starling_debug_client = true

module Starling

  VERSION = "0.9.2"

  class QueueCollection

    attr_reader :total_items, :current_bytes, :get_hits, :get_misses, :queues

    def initialize(persistence_path)
      @queues = {}
      @persistence_path = persistence_path
      @queue_init_mutexes = {}
      @current_bytes = 0
      @total_items = 0
      @get_hits = 0
      @get_misses = 0
    end

    def put(key, data)
      queue = queues(key)
      return nil unless queue

      @current_bytes += data.size
      @total_items += 1
      queues(key).push(data)
      
      return true
    end

    def take(key)
      queue = queues(key)
      if queue.nil? || queue.length == 0
        @get_misses += 1
        return nil
      else
        @get_hits += 1
      end
      result = queue.pop
      @current_bytes -= result.size
      result
    end

    def queues(key=nil)
      return @queues if key.nil?

      # First try to return the queue named 'key' if it's available.
      return @queues[key] if @queues[key]

      @queue_init_mutexes[key] ||= Mutex.new

      # Otherwise, check to see if another process is already loading
      # the queue named 'key'.
      if @queue_init_mutexes[key].locked?
        # return an empty/false result if we're waiting for the queue
        # to be loaded and we're not the first process to request the queue
        return nil
      else
        begin
          @queue_init_mutexes[key].lock
          # we've locked the mutex, but only go ahead if the queue hasn't
          # been loaded. There's a race condition otherwise, and we could
          # end up loading the queue multiple times.
          if @queues[key].nil?
            @queues[key] = PersistentQueue.new(@persistence_path, key)
            @current_bytes += @queues[key].initial_bytes
          end
        rescue Object => exc
          puts "ZOMG There was an exception reading back the queue. That totally sucks."
          puts "The exception was: #{exc}. Backtrace: #{exc.backtrace.join("\n")}"
        ensure
          @queue_init_mutexes[key].unlock
        end
      end

      return @queues[key]
    end

    def current_size
      @queues.inject(0) { |m, (k,v)| m + v.length }
    end
  end

  class PersistentQueue < Queue

    SOFT_LOG_MAX_SIZE = 16777216

    TRX_CMD_PUSH = "\000".freeze
    TRX_CMD_POP = "\001".freeze

    TRX_PUSH = "\000%s%s".freeze
    TRX_POP = "\001".freeze

    attr_reader :initial_bytes, :total_items, :logsize

    def initialize(persistence_path, queue_name)
      @persistence_path = persistence_path
      @queue_name = queue_name
      @transaction_mutex = Mutex.new
      @total_items = 0
      @initial_bytes = replay_transaction_log
      super()
    end

    def log_path
      "#{@persistence_path}/#{@queue_name}"
    end

    def reopen_log
      @trx = File.new(log_path, File::CREAT|File::RDWR)
      @logsize = File.size(log_path)
    end

    def rotate_log
      @trx.close
      File.rename(log_path, "#{log_path}.#{Time.now.to_i}")
      reopen_log
    end

    def replay_transaction_log
      reopen_log
      bytes_read = 0

      print "Reading back transaction log for #{@queue_name} "

      while !@trx.eof?
        cmd = @trx.read(1)
        case cmd
        when TRX_CMD_PUSH
          print ">"
          size = @trx.read(4).unpack("I").first
          data = @trx.read(size)
          push(data, false)
          bytes_read += data.size
        when TRX_CMD_POP
          print "<"
          bytes_read -= pop(false).size
        else
          print "E"
          puts "Error reading transaction log: I don't understand '#{cmd}' (skipping)." if $starling_debug_client
        end
      end

      print " done.\n"

      return bytes_read
    end

    def push(value, log_trx = true)
      @total_items += 1
      if log_trx
        size = [value.size].pack("I")
        transaction sprintf(TRX_PUSH, size, value)
      end
      super(value)
    end

    def pop(log_trx = true)
      begin
        rv = super(!log_trx)
      rescue ThreadError
        puts "WARNING: The queue was empty when trying to pop(). Technically this shouldn't ever happen. Probably a bug in the transactional underpinnings. Or maybe shutdown didn't happen cleanly at some point. Ignoring."
        rv = ''
      end
      transaction "\001" if log_trx
      rv
    end

    def transaction(data)
      raise "no transaction log handle. that totally sucks." unless @trx

      begin
        @transaction_mutex.lock
        @trx.write data
        @logsize += data.size
        rotate_log if @logsize > SOFT_LOG_MAX_SIZE && self.length == 0
      ensure
        @transaction_mutex.unlock
      end
    end
  end

  class StopServer < Exception; end

  class Server

    attr_accessor :bytes_read, :bytes_written, :get_requests, :set_requests
    attr_reader :start_time

    def initialize(host, port, persistence_path, num_processors=(2**30-1), timeout=0)
      require 'socket'
      @socket = TCPServer.new(host, port)

      @socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
      @socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_KEEPALIVE, true)

      @host = host
      @port = port
      @persistence_path = persistence_path
      @workers = ThreadGroup.new
      @total_connections = 0
      @timeout = timeout
      @num_processors = num_processors
      @death_time = 60

      @queue_collection = QueueCollection.new(persistence_path)

      @bytes_read = 0
      @bytes_written = 0

      @set_requests = 0
      @get_requests = 0
    end

    def run
      @start_time = Time.now

      BasicSocket.do_not_reverse_lookup = true

      @acceptor = Thread.new do
        loop do
          begin
            client = @socket.accept

            @total_connections += 1
            worker_list = @workers.list

            if worker_list.length >= @num_processors
              STDERR.puts "Server overloaded with #{worker_list.length} processors (#@num_processors max). Dropping connection."
              begin
                client.close
              rescue Object => e
                STDERR.puts "Got exception closing socket (while dealing with overloaded processors) #{e}"
              end
              reap_dead_workers("max processors")
            else
              thread = Thread.new(client) {|c| process_client(c) }
              thread[:last_activity] = Time.now
              @workers.add(thread)

              sleep @timeout/100 if @timeout > 0
            end
          rescue StopServer
            @socket.close rescue Object
            break
          rescue Errno::EMFILE
            reap_dead_workers("too many open files")
            sleep 0.1
          rescue Errno::ECONNABORTED
            # client closed the socket even before accept
            begin
              client.close
            rescue Object => e
              STDERR.puts "Got exception closing socket (client aborted connection) #{e}"
            end
          rescue Object => exc
            STDERR.puts "!!!!!!! UNHANDLED EXCEPTION! #{exc}.  TELL BLAINE HE'S A MORON."
            STDERR.puts $!.backtrace.join("\n") if $starling_debug_client
          end
        end
        graceful_shutdown
      end

      return @acceptor
    end

    def stop
      stopper = Thread.new do
        exc = StopServer.new
        @acceptor.raise(exc)
      end
      stopper.priority = 10
    end

    def process_client(client)
      begin
        queue_handler = Handler.new(client, self, @queue_collection)
        queue_handler.run
      rescue EOFError,Errno::ECONNRESET,Errno::EPIPE,Errno::EINVAL,Errno::EBADF
        begin
          client.close
        rescue Object => e
          STDERR.puts "Got exception closing socket (while handling connection error) #{e}"
        end
      rescue TimeoutError => reason
        begin
          STDERR.puts "#{Time.now}: Client being killed by a timeout: #{reason.message}"
          client.close
        rescue Object => e
          STDERR.puts "Got exception while closing socket (dealing with Timeout Error) #{e}"
        end
      rescue Errno::EMFILE
        reap_dead_workers('too many files')
      rescue Object
        STDERR.puts "#{Time.now}: ERROR: #$!"
        STDERR.puts $!.backtrace.join("\n") if $starling_debug_client
      ensure
        begin
          client.close
        rescue Object => e
          STDERR.puts "Got exception closing socket (routine close) #{e}"
        end
      end
    end

    def reap_dead_workers(reason='unknown')
      if @workers.list.length > 0
        STDERR.puts "#{Time.now}: Reaping #{@workers.list.length} threads for dead workers because of '#{reason}'"
        error_msg = "Starling timed out this thread: #{reason}"
        mark = Time.now
        @workers.list.each do |w|
          w[:last_activity] = Time.now if not w[:last_activity]

          if mark - w[:last_activity] > @death_time + @timeout
            STDERR.puts "Thread #{w.inspect} is too old, killing."
            w.raise(TimeoutError.new(error_msg))
          end
        end
      end

      return @workers.list.length
    end

    def graceful_shutdown
      @workers.list.each do |w|
        w[:shutdown] = true
      end

      while reap_dead_workers("shutdown") > 0
        STDERR.print "Waiting for #{@workers.list.length} requests to finish, could take #{@death_time + @timeout} seconds."
        sleep @death_time / 10
      end
    end

    def connections
      @workers.list.length
    end

    def total_connections
      @total_connections
    end

    def max_size
      0
    end
  end

  class Handler

    DATA_PACK_FMT = "Ia*".freeze

    # ERROR responses
    ERR_UNKNOWN_COMMAND = "CLIENT_ERROR bad command line format".freeze

    # GET Responses
    GET_COMMAND_PATTERN = /^get (.{1,250})\r\n$/
    GET_RESPONSE       = "VALUE %s %s %s\r\n%s\r\nEND\r\n".freeze
    GET_RESPONSE_EMPTY = "END\r\n".freeze

    # SET Responses
    SET_COMMAND_PATTERN = /^set (.{1,250}) ([0-9]+) ([0-9]+) ([0-9]+)\r\n$/
    SET_RESPONSE_SUCCESS  = "STORED\r\n".freeze
    SET_RESPONSE_FAILURE  = "NOT STORED\r\n".freeze
    SET_CLIENT_DATA_ERROR = "CLIENT_ERROR bad data chunk\r\nERROR\r\n".freeze

    # STAT Response
    STATS_COMMAND_PATTERN = /stats\r\n$/
    STATS_RESPONSE = "STAT pid %d\nSTAT uptime %d
STAT time %d
STAT version %s
STAT rusage_user %0.6f
STAT rusage_system %0.6f
STAT curr_items %d
STAT total_items %d
STAT bytes %d
STAT curr_connections %d
STAT total_connections %d
STAT cmd_get %d
STAT cmd_set %d
STAT get_hits %d
STAT get_misses %d
STAT bytes_read %d
STAT bytes_written %d
STAT limit_maxbytes %d
%sEND\r\n".freeze

    def initialize(client, server, queue_collection)
      @client = client
      @server = server
      @queue_collection = queue_collection
      @expiry_stats = Hash.new(0)
    end

    def running?
      !Thread.current[:shutdown]
    end

    def run
      begin
        while running? do
          process_command(@client.readline)
          Thread.current[:last_activity] = Time.now
        end
      end
    end

    def process_command(command)
      begin
        @server.bytes_read += command.length
        case command
        when SET_COMMAND_PATTERN
          @server.set_requests += 1
          set($1, $2, $3, $4.to_i)
        when GET_COMMAND_PATTERN
          @server.get_requests += 1
          get($1)
        when STATS_COMMAND_PATTERN
          stats
        else
          puts "got unknown command: #{command[0,4]} full command was #{command}."
          respond ERR_UNKNOWN_COMMAND, command[0,4]
        end
      rescue => e
        puts "got an error handling request: #{e}."
        respond GET_RESPONSE_EMPTY
      end
    end

    def set(key, flags, expiry, len)
      data = @client.read(len)
      data_end = @client.read(2)
      @server.bytes_read += len + 2
      if data_end == "\r\n" && data.size == len
        internal_data = [expiry.to_i, data].pack(DATA_PACK_FMT)
        if @queue_collection.put(key, internal_data)
          respond SET_RESPONSE_SUCCESS
        else
          respond SET_RESPONSE_FAILURE
        end
      else
        respond SET_CLIENT_DATA_ERROR
      end
    end

    # Fetches a value from the queue specified by <key>
    def get(key)
      now = Time.now.to_i
      data = nil
      while response = @queue_collection.take(key)
        expiry, data = response.unpack(DATA_PACK_FMT)
        break if expiry == 0 || expiry >= now
        @expiry_stats[key] += 1
        expiry, data = nil
      end

      if data
        respond GET_RESPONSE, key, 0, data.size, data
      else
        respond GET_RESPONSE_EMPTY
      end
    end

    def stats
      respond STATS_RESPONSE, 
        Process.pid, # pid
        Time.now - @server.start_time, # uptime
        Time.now.to_i, # time
        Starling::VERSION, # version
        Process.times.utime, # rusage_user
        Process.times.stime, # rusage_system
        @queue_collection.current_size, # curr_items
        @queue_collection.total_items, # total_items
        @queue_collection.current_bytes, # bytes
        @server.connections, # curr_connections
        @server.total_connections, # total_connections
        @server.get_requests, # get count
        @server.set_requests, # set count
        @queue_collection.get_hits,
        @queue_collection.get_misses,
        @server.bytes_read, # total bytes read
        @server.bytes_written, # total bytes written
        @server.max_size, # limit_maxbytes
        queue_stats
    end

    def queue_stats
      @queue_collection.queues.inject("") do |m,(k,v)|
        m +
        "STAT queue_#{k}_items #{v.length}\n" +
        "STAT queue_#{k}_total_items #{v.total_items}\n" +
        "STAT queue_#{k}_logsize #{v.logsize}\n" +
        "STAT queue_#{k}_expired_items #{@expiry_stats[k]}\n"
      end
    end

    def respond(str, *args)
      response = sprintf(str, *args)
      @server.bytes_written += response.length
      @client.write response
    end
  end
end
