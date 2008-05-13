require 'rubygems'
require 'net/ssh'
Net::SSH.start('slicehost.radicaldesigns.org', 'patrice') do
  `cd /var/www/daysofaction/current`
  print "Enter slicehost database password: "
  pwd = gets
  `mysqldump -u root -p #{pwd} daysofaction_production > live_db.sql`
  `zip live_db.zip live_db.sql`
end
`scp root@slicehost.radicaldesigns.org:/var/www/daysofaction/current/live_db.zip .`
`unzip live_db.zip`
=begin
print "Enter local database password: "
pwd = gets
`mysqldump -u root -p #{pwd} daysofaction_development sites > local_sites.sql`   # save local sites table
`mysql -u root -p #{pwd} drop database daysofaction_development`                 # trash the old one
`mysql -u root -p #{pwd} create database daysofaction_development`               # create new one
`mysql -u root -p #{pwd} daysofaction_development < live_db.sql`                 # fill her up with live data
=end
