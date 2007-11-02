#!/usr/bin/env ruby

ENV['RAILS_ENV'] = ENV['RAILS_ENV'] || 'production'
require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
require File.expand_path(File.dirname(__FILE__) + '/../config/environment')

require 'daemons'

Daemons.run_proc("report_processor", 
                 :log_output => true, 
                 :dir_mode => :normal, 
                 :dir => "#{RAILS_ROOT}/log") do
  ReportProcessor.run
end
