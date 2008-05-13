class Candidate < Politician
  validates_presence_of :display_name, :office

  def validate
    case office
    when "representative"
      if state.blank?: errors.add(:state, "must be set for Representative candidates") end
      if district.blank?: errors.add(:district, "must be set for Representative candidates") end
    when "senator"
      if state.blank?: errors.add(:state, "must be set for Senate candidates") end
    end
  end

  before_save :set_district_and_district_type
  def set_district_and_district_type
    case office
    when "president"
      self.district_type = self.district = nil
    when "senator"
      self.district_type = "FS"
      unless state.blank?
        if district.blank?
          self.district = state + "1"
        elsif district.to_i > 2
          self.district = state + "1"
        else
          self.district = state + district
        end
      end
    when "representative"
      self.district_type = "FH"
      unless state.blank? or district.blank?
        self.district = state + sprintf("%02d", district)
      end
    end
  end

  def self.build_from_democracy_in_action_recipient_hash(hash)
    c = new
    c.image_url = hash['image_url']
    c.postal_code = hash['postal_code']
    c.title = hash['honorific']
    c.phone = hash['phone']
    c.first_name = hash['given_name']
    c.last_name = hash['family_name']
    c.display_name = [c.title, c.first_name, c.last_name].join(' ')
    c.address = hash['address_line']
    c.email = hash['email']
    c
  end

  def self.import_presidential_candidate(hash)
    hash.map {|k,v| v.strip!}
    c = build_from_democracy_in_action_recipient_hash(hash)
    c.office = "president"
    c.save
    c.create_democracy_in_action_object :table => 'recipient', :key => hash['key'], :local => hash
    c
  end
=begin
recipients = api.get 'recipient'
recipients.each {|r| Candidate.import_presidential_candidate(r) }
=end
end
