class CalendarHasManyCalendars < ActiveRecord::Migration
  def self.up
    add_column :calendars, :parent_id, :integer
    add_index :calendars, :parent_id
    s = Site.find_by_theme('catalogcutdown')
    all_calendar = s.calendars.create(:permalink => 'all', :name => 'Catalog Cutdown', :theme => s.theme)
    s.calendars.each do |c|
      next if c.id == all_calendar.id
      c.parent_id = all_calendar.id
      c.save
    end
  end

  def self.down
    s = Site.find_by_theme('catalogcutdown')
    s.calendars.find_by_permalink('all').destroy
    remove_index :calendars, :parent_id
    remove_column :calendars, :parent_id
  end
end
