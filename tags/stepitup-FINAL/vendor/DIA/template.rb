class :CLASS: <  DemocracyInActionResource
	@@atts = :ATTS:

	@@links = :LINKS:

	@@multilinks = :MULTILINKS:

	# return db table associated with this class
  def :CLASS:.table
    ':TABLE:'
  end

	# return hash of all valid columns
	def :CLASS:.atts
		@@atts
	end

	# return hash of columns that are links
	def :CLASS:.links
		@@links
	end

	# return hash of columns that are multilinks
	def :CLASS:.multilinks
		@@multilinks
	end

	# optional to control the display in list
	def :CLASS:.columns
		return self.atts.keys
	end

	def initialize(hash = nil)
		if hash == nil
			@data = Hash.new
		elsif bad_key = hash.keys.detect { |k| !self.class.atts[k] }
			raise 'Bad argument to initialize: ' + bad_key
		else
			@data = hash.dup
		end
	end

end

