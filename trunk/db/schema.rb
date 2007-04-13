# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 29) do

  create_table "attachments", :force => true do |t|
    t.column "content_type", :string
    t.column "filename",     :string
    t.column "size",         :integer
    t.column "parent_id",    :integer
    t.column "thumbnail",    :string
    t.column "width",        :integer
    t.column "height",       :integer
    t.column "caption",      :string
    t.column "url",          :string
    t.column "position",     :integer
    t.column "author",       :string
    t.column "type",         :string
    t.column "user_id",      :integer
    t.column "event_id",     :integer
    t.column "report_id",    :integer
    t.column "primary",      :boolean, :default => false
  end

  add_index "attachments", ["report_id"], :name => "index_attachments_on_report_id"
  add_index "attachments", ["parent_id"], :name => "index_attachments_on_parent_id"

  create_table "blogs", :force => true do |t|
    t.column "title",      :string
    t.column "body",       :text
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "event_id",   :integer
  end

  create_table "calendars", :force => true do |t|
    t.column "name",              :string
    t.column "short_description", :text
    t.column "user_id",           :integer
  end

  create_table "events", :force => true do |t|
    t.column "name",                  :string
    t.column "short_description",     :text
    t.column "description",           :text
    t.column "calendar_id",           :integer
    t.column "location",              :text
    t.column "city",                  :string
    t.column "state",                 :string
    t.column "postal_code",           :string
    t.column "host_id",               :integer
    t.column "start",                 :datetime
    t.column "end",                   :datetime
    t.column "service_foreign_key",   :string
    t.column "latitude",              :float
    t.column "longitude",             :float
    t.column "directions",            :text
    t.column "person_legislator_ids", :string
    t.column "district",              :string
    t.column "campaign_key",          :integer
  end

  add_index "events", ["latitude", "longitude"], :name => "index_events_on_latitude_and_longitude"
  add_index "events", ["postal_code"], :name => "index_events_on_postal_code"
  add_index "events", ["state", "city"], :name => "index_events_on_state_and_city"
  add_index "events", ["service_foreign_key"], :name => "index_events_on_service_foreign_key"

  create_table "press_links", :force => true do |t|
    t.column "url",       :string
    t.column "text",      :string
    t.column "report_id", :integer
  end

  create_table "reports", :force => true do |t|
    t.column "event_id",       :integer
    t.column "user_id",        :integer
    t.column "text",           :text
    t.column "position",       :integer
    t.column "status",         :string
    t.column "reporter_name",  :string
    t.column "reporter_email", :string
    t.column "embed",          :text
    t.column "attendees",      :integer
  end

  add_index "reports", ["event_id"], :name => "index_reports_on_event_id"
  add_index "reports", ["status"], :name => "index_reports_on_status"
  add_index "reports", ["status", "position"], :name => "index_reports_on_status_and_position"

  create_table "roles", :force => true do |t|
    t.column "title", :string
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.column "role_id", :integer
    t.column "user_id", :integer
  end

  create_table "rsvps", :id => false, :force => true do |t|
    t.column "event_id", :integer
    t.column "user_id",  :integer
    t.column "comment",  :text
    t.column "guests",   :integer
  end

  create_table "sessions", :force => true do |t|
    t.column "session_id", :string
    t.column "data",       :text
    t.column "updated_at", :datetime
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sites", :force => true do |t|
    t.column "host",                         :string
    t.column "use_democracy_in_action_auth", :boolean
    t.column "theme",                        :string
  end

  add_index "sites", ["host"], :name => "index_sites_on_host"

  create_table "taggings", :force => true do |t|
    t.column "tag_id",        :integer, :default => 0,  :null => false
    t.column "taggable_id",   :integer, :default => 0,  :null => false
    t.column "taggable_type", :string,  :default => "", :null => false
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], :name => "index_taggings_on_tag_id_and_taggable_id_and_taggable_type", :unique => true

  create_table "tags", :force => true do |t|
    t.column "name", :string, :default => "", :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.column "login",                     :string
    t.column "email",                     :string
    t.column "crypted_password",          :string,   :limit => 40
    t.column "salt",                      :string,   :limit => 40
    t.column "created_at",                :datetime
    t.column "updated_at",                :datetime
    t.column "remember_token",            :string
    t.column "remember_token_expires_at", :datetime
    t.column "first_name",                :string
    t.column "last_name",                 :string
    t.column "phone",                     :string
    t.column "street",                    :string
    t.column "street_2",                  :string
    t.column "city",                      :string
    t.column "state",                     :string
    t.column "postal_code",               :string
  end

  create_table "zip_codes", :force => true do |t|
    t.column "zip",       :string
    t.column "city",      :string
    t.column "state",     :string, :limit => 2
    t.column "latitude",  :float
    t.column "longitude", :float
    t.column "zip_class", :string
  end

  add_index "zip_codes", ["zip"], :name => "index_zip_codes_on_zip"
  add_index "zip_codes", ["latitude"], :name => "index_zip_codes_on_latitude"
  add_index "zip_codes", ["longitude"], :name => "index_zip_codes_on_longitude"
  add_index "zip_codes", ["latitude", "longitude"], :name => "index_zip_codes_on_latitude_and_longitude"

end
