# This defines a Resource for the :TABLE: table in the DIA API
#
# note that the convenience functions att, links, multilinks, table
# must be defined in every subclass of DemocracyInActionResource
# so the code in the parent class can work properly
class :CLASS: <  DemocracyInActionResource
	# all attributes (columns) for this table.
	# stored as a hash table (name => 1)
	@@atts = :ATTS:

	# a list of all attributes that are links to another table
	# stored as a hash table (name => Class to link to)
	@@links = :LINKS:

	# same as @@links, but these end with _KEYS and allow one to
	# link to multiple elements.
	@@multilinks = :MULTILINKS:

	# return db table associated with this class, used for DIA API calls
  def :CLASS:.table
    ':TABLE:'
  end

	# return hash of all valid columns, keys are column names
	def :CLASS:.atts
		@@atts
	end

	# return hash, keys are columns, values are classes they link to
	def :CLASS:.links
		@@links
	end

	# return hash, keys are columns, values are classes they link to
	# difference between links is that these can point to multiple elements
	def :CLASS:.multilinks
		@@multilinks
	end

	# optional to control the display in list
	# (only used in the test display code, you can ignore)
	def :CLASS:.columns
		return self.atts.keys
	end

	# create a new instance with all the attributes set from a hash table
	def initialize(hash = nil)
		if hash == nil
			@data = Hash.new
		elsif bad_key = hash.keys.detect { |k| !self.class.atts[k.to_s] }
			raise 'Bad argument to initialize: ' + bad_key.to_s
		else
      @data = Hash.new
      hash.each { |k, v| @data[k.to_s] = v.to_s }
		end
	end

end

