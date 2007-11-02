#!/usr/bin/env ruby

require 'rubygems'
require 'daemons'

Daemons.run(File.dirname(__FILE__) + "/starling_runner.rb", 
                 :log_output => true, 
                 :dir_mode => :normal, 
                 :dir => File.dirname(__FILE__) + "/../log") 
