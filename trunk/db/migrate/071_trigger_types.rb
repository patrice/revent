class TriggerTypes < ActiveRecord::Migration
  def self.up
    # create table
    create_table :trigger_types do |table|
      table.column :tag,         :string
      table.column :name,         :string
      table.column :description,  :text
    end
    add_column :triggers, :type_id, :integer
    # fill 'er up
    TriggerType.create(:tag => "rsvp_thank_you", :name => "RSVP Thank You Email", :description => "This thank you email will be sent to users after they RSVP to an event.")
    TriggerType.create(:tag => "report_thank_you", :name => "Report-back Thank You Email", :description => "This thank you email will be sent to users after they submit a report.")
    TriggerType.create(:tag => "report_host_reminder", :name => "Report-back Reminder for Host", :description => "This email will be sent to hosts the day after their event.  It should encourage them to tell event attendees to submit a report.")
  end
  
  def self.down
    drop_table "trigger_types"
    remove_column :triggers, :type_id
  end
end
