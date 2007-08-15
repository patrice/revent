class CreatePoliticianInvites < ActiveRecord::Migration
  def self.up
    add_column :events, :district_id, :integer
    create_table :politicians do |t|
      t.column :title, :string
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :district_id, :integer
      #t.column :image, :byte
    end
    create_table :politician_invites do |t|
      t.column :user_id, :integer
      t.column :politician_id, :integer
      t.column :event_id, :integer
      t.column :invite_type, :integer # call/email/letter
    end
=begin
# perhaps do this in future but not right now
    create_table :invite_scripts do |t|
      t.column :event_id, :integer
      t.column :invite_type, :integer # call/email/letter
      t.column :script, :string
    end
=end
end

  def self.down
    remove_column :events, :district_id
    drop_table :politicians
    drop_table :politician_invites
  end
end
