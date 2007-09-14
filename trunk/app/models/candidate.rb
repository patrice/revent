class Candidate < Politician
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
