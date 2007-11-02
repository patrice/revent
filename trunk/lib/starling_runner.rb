require 'rubygems'
require File.dirname(__FILE__) + '/starling'

if File.exists?("/opt/csw/bin/myprivateip")
  ip = `/opt/csw/bin/myprivateip`
else
  ip = "127.0.0.1"
end

s = Starling::Server.new(ip, 22122, '/var/log/starling/')
server = s.run
server.join
