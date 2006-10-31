# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 5) do

  create_table "event_groups", :force => true do |t|
    t.column "name", :string
    t.column "short_description", :text
    t.column "user_id", :integer
  end

  create_table "events", :force => true do |t|
    t.column "name", :string
    t.column "short_description", :text
    t.column "description", :text
    t.column "event_group_id", :integer
    t.column "location", :text
    t.column "city", :string
    t.column "state", :string
    t.column "postal_code", :string
    t.column "host_id", :integer
    t.column "start", :datetime
    t.column "end", :datetime
  end

  create_table "medias", :force => true do |t|
    t.column "content_type", :string
    t.column "filename", :string
    t.column "size", :integer
    t.column "parent_id", :integer
    t.column "thumbnail", :string
    t.column "width", :integer
    t.column "height", :integer
    t.column "caption", :string
    t.column "url", :string
    t.column "position", :integer
    t.column "author", :string
    t.column "type", :string
    t.column "user_id", :integer
    t.column "event_id", :integer
  end

  create_table "reports", :force => true do |t|
    t.column "event_id", :integer
    t.column "user_id", :integer
    t.column "text", :text
    t.column "position", :integer
  end

  create_table "rsvps", :id => false, :force => true do |t|
    t.column "event_id", :integer
    t.column "user_id", :integer
    t.column "comment", :text
    t.column "guests", :integer
  end

  create_table "users", :force => true do |t|
    t.column "login", :string
    t.column "email", :string
    t.column "crypted_password", :string, :limit => 40
    t.column "salt", :string, :limit => 40
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "remember_token", :string
    t.column "remember_token_expires_at", :datetime
  end

end
