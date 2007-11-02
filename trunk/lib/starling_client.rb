require 'memcache'

class StarlingTimeout < Timeout::Error; end

class Starling < MemCache

  def self.waiting?
    @waiting
  end

  def self.waiting=(v)
    @waiting = v
  end

  def get(*args)
    loop do
      response = super(*args)
      return response unless response.nil?
      self.class.waiting = true
      sleep 0.25
      self.class.waiting = false
    end
  end
  
  def get_server_for_key(key)
    raise ArgumentError, "illegal character in key #{key.inspect}" if key =~ /\s/
    raise ArgumentError, "key too long #{key.inspect}" if key.length > 250
    raise MemCacheError, "No servers available" if @servers.empty?

    bukkits = @buckets.dup
    bukkits.nitems.times do |try|
      n = rand(bukkits.nitems)
      server = bukkits[n]
      return server if server.alive?
      bukkits.delete_at(n)
    end

    raise MemCacheError, "No servers available (all dead)"
  end

  def set(*args)
    retries = 0
    begin
      rv = super(*args)
      "STORED\r\n"
    rescue MemCache::MemCacheError => e
      retries += 1
      sleep 0.25
      retry unless retries > 4 # wait up to 1 second for a server to become available / provide a valid response.
      raise e
    end
  end

  def flush(queue)
    sizeof(queue).times do
      v = get(queue)
      yield v if block_given?
    end
  end

  def sizeof(queue)
    if queue == :all
      queue_sizes = {}
      available_queues.each do |queue|
        queue_sizes[queue] = sizeof(queue)
      end
      queue_sizes
    else
      stats.inject(0) { |m,(k,v)| m + v["queue_#{queue}_items"].to_i }
    end
  end

  def available_queues
    all_keys = stats.map { |k,v| v.keys }.flatten.uniq
    all_keys.grep(/^queue_(.*)_items/).map { |v|
      v.gsub(/^queue_/, '').gsub(/_items$/, '')
    }.reject { |v|
      v =~ /_total$/ || v =~ /_expired$/
    }
  end
end

class MemCache
  class Server
    def socket
       @mutex.lock if @multithread
       return @sock if @sock and not @sock.closed?
     
       @sock = nil
     
       # If the host was dead, don't retry for a while.
       return if @retry and @retry > Time.now
     
       # Attempt to connect if not already connected.
       begin
         @sock = timeout CONNECT_TIMEOUT do
           TCPSocket.new @host, @port
         end
         @sock.setsockopt(Socket::SOL_SOCKET, Socket::SO_KEEPALIVE, true)
         @retry  = nil
         @status = 'CONNECTED'
       rescue SocketError, SystemCallError, IOError, Timeout::Error => err
         mark_dead err.message
       end
 
       return @sock
     ensure
       @mutex.unlock if @multithread
     end
  end
end
