#!/usr/bin/ruby

# This is used when a table connects two different classes
# (ex. supporter_groups is N to N map between supporter and groups)
# First, use generate_class supporter_groups
# Then,  use generate_links supporter_groups
# The second one adds stubs in Supporter andd Groups, providing
#  easy accessors to follow the mappings

require 'DIA_API'

table = ARGV[0]
if !table
	puts 'Usage: generate_links <table name>'
	exit(1)
end

def to_class_name(str)
	str.capitalize.gsub(/_(\w)/) { |s| s[1..1].capitalize }
end

def generate_link_code(from_table, to_table, linking_class)
	from_class = to_class_name(from_table)
	to_class = to_class_name(to_table)

	output = "
class #{from_class} < DemocracyInActionResource
  def #{to_table}_KEYS
		links = #{linking_class}.find(:all, :conditions => '#{from_table}_KEY='+key)
		links.map{ |l| l.#{to_table}_KEY }
	end

	def #{to_table}
		keys = self.#{to_table}_KEYS
		if keys.size == 0
			return []
		else
			#{to_class}.find(keys)
		end
	end
end"
end

def insert_link_code(from_table, to_table, linking_class)
	# verify the files are there...
	to_dir = '../../app/models/'
	outfile = to_dir + from_table + '.rb'
	if !File.exists?(outfile)
		puts "Can't write out link code, because #{outfile} doesn't exist."
		return
	end

	# write the code out to the end of the file
	puts "Adding code to #{outfile}"
	code = generate_link_code(from_table, to_table, linking_class)
	File.open(outfile, 'a') { |out| out.write(code) }
end


def generate_atts_code(from_table, to_table, linking_table)
	from_class = to_class_name(from_table)
	to_class = to_class_name(to_table)
	linking_class = to_class_name(linking_table)

	output = "
class #{linking_class} < DemocracyInActionResource
        @@atts = @@atts.merge(#{from_class}.atts).merge(#{to_class}.atts)
end"
end

def insert_atts_code(from_table, to_table, linking_table)
	# verify the files are there...
	to_dir = '../../app/models/'
	outfile = to_dir + linking_table + '.rb'
	if !File.exists?(outfile)
		puts "Can't write out link code, because #{outfile} doesn't exist."
		return
	end

	# write the code out to the end of the file
	puts "Adding code to #{outfile}"
	code = generate_atts_code(from_table, to_table, linking_table)
	File.open(outfile, 'a') { |out| out.write(code) }
end

# classes[0, 1] are the ones to link
# table is the linking table
classes = table.split('_')

# classname is the ruby name of the linking table
# linkednames[0, 1] are the ruby names of the linked tables
classname = to_class_name(table)

# some debug output...
puts 'table: ' + table
puts 'classname: ' + classname
puts 'classes: ' + classes.join(', ')

insert_link_code(classes[0], classes[1], classname)
insert_link_code(classes[1], classes[0], classname)
insert_atts_code(classes[0], classes[1], table)
