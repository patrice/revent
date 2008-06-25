load File.dirname(__FILE__) + '/../config/environment.rb'
admins =
"Susannah Cowden,  scowden@bethechangeinc.org
Emily Cherniack, echerniack@bethechangeinc.org
Nicole Goberdhan, ngoberdhan@bethechangeinc.org
Tara Venkatraman, tvenkatram@bethechangein.org
Naomi Porper, nporper@bethechangeinc.org
Katie Visco, kvisco@bethechangeinc.org
Irene Jor, ijor@bethechangeinc.org
Sonia Tapryal, stapryal@bethechangeinc.org
Jess Camacho, jcamacho@bethechangeinc.org"

Site.current  = Site.find(13)
admins = admins.split('\n')
admins.each do |a|
  admin = a.split(',')
  full_name = admin.first.strip
  email = admin.last.strip
  u = Site.current.users.build(:first_name => full_name.split.first, :last_name => full_name.split.last, :email => email)
  u.password = "changeme"
  u.password_confirmation = "changeme"
  u.save
  u.roles << Role.find_by_title("admin")
end
