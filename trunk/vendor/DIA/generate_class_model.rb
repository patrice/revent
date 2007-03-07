#!/usr/bin/ruby

require 'DIA_API'

table = ARGV[0]
if !table
	puts 'Usage: generate_class <table name>'
	exit(1)
end

CLASS_PREFIX = ARGV[1] || ''

API_OPTS = { 'authCodes' => [ 'test', 'test', 962 ] }
API = DIA_API.create(API_OPTS)
desc = API.describe(table).map{|f| f.field}

def table_atts(desc)
	out = '{"key" => 1, '
	desc.each{|a| out += "\"#{a}\"=>1, "}
	out = out[0..-3] + '}'
end

def table_links(desc, classname, table)
	out = '{'
	min = out.size
	desc.find_all{|f| f[-4..-1] == '_KEY'}.each do |link|
		l_name = link[0..-5]
		if l_name != table
			if (l_name == 'parent') or (l_name == 'root')
				l_class = to_class_name(table)
			else
				l_class = to_class_name(l_name.sub('default_', ''))
			end
			out += "'#{l_name}'=>#{l_class}, "
		end
	end
	if out.size > min: out = out[0..-3] end
	out + '}'
end

def table_multilinks(desc)
	out = '{'
	min = out.size
	desc.find_all{|f| f[-5..-1] == '_KEYS'}.each do |mlink|
		ml_name = mlink[0..-6]
		# strips off everything before a $, for email_triggers mainly
		ml_name.gsub!(/.*\$/, '')   
		ml_class = to_class_name(ml_name)
		out += "'#{ml_name}'=>#{ml_class}, "
	end
	if out.size > min: out = out[0..-3] end
	out + '}'
end

def to_class_name(str)
	CLASS_PREFIX + str.capitalize.gsub(/_(\w)/) { |s| s[1..1].capitalize }
end

# takes a file and does all substitutions on it
def translate_file(filename, table, classname, atts, links, mlinks)
	text = IO.read(filename)
	text.gsub!(/:TABLE:/, table)
	text.gsub!(/:CLASS:/, classname)
	text.gsub!(/:ATTS:/, atts)
	text.gsub!(/:LINKS:/, links)
	text.gsub!(/:MULTILINKS:/, mlinks)
	return text
end

classname = to_class_name(table)
atts = table_atts(desc)
links = table_links(desc, classname, table)
mlinks = table_multilinks(desc)

# some debug output...
puts 'table: ' + table
puts 'classname: ' + classname
puts 'atts: ' + atts
puts 'links: ' + links
puts 'multilinks: ' + mlinks

# now that we have prepared everything, generate all the classes...
from_dir = 'template/'
to_dir = './'


files = [ 'models/template.rb' ]

files.each do |file|
	outfile = file.gsub(/models\/template/, table)
	puts 'copying file: ' + from_dir+file + ' to ' + outfile
	text = translate_file(from_dir+file, table, classname, atts, links, mlinks)
	File.open(outfile, 'w') { |output| output.write(text) }
end
