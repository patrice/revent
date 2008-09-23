require 'user'
require 'democracy_in_action_object'
require 'press_link'

class ExportWorker < Workling::Base
  def export_users(site_id, start)
    Site.current = Site.find(site_id)
    @users = Site.current.users.find(:all, :include => :custom_attributes)
    @attribute_names = @users.inject([]) {|names, u| names << u.custom_attributes.map {|a| a.name }; names.flatten.compact.uniq }
    require 'fastercsv'
    string = FasterCSV.generate do |csv|
      csv << ["Email", "First_Name", "Last_Name", "Phone", "Street", "Street_2", "City", "State", "Postal_Code", "Partner_Code", "Events_Hosting_IDS", "Events_Attending_IDS"] + @attribute_names
      @users.each do |user|
        csv << [user.email, user.first_name, user.last_name, user.phone, user.street, user.street_2, user.city, user.state, user.postal_code, user.partner_id] + [ user.event_ids.join(','), user.attending_ids.join(',') ] + @attribute_names.map {|a| user.custom_attributes_data.send(a.to_sym) }
      end
    end
    temp_file = File.join(RAILS_ROOT, 'tmp', "#{Site.current.theme}_users.csv")
    TempFile.open(temp_file, "w+") {|f| f << string}
    download_file = File.join(RAILS_ROOT, 'tmp', "#{Site.current.theme}_users_#{start}.csv")
    FileUtils.cp temp_file, download_file
  end
end
