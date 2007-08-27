module DemocracyInAction
  module Helpers
    def self.title_options_for_select
      [ 
        ["Select Title", ""],
        ["Mr.", "Mr."],
        ["Mrs.", "Mrs."],
        ["Ms.", "Ms."],
        ["Dr.", "Dr."],
        ["Rabbi", "Rabbi"],
        ["Fr.", "Fr."],
        ["Rev.", "Rev."],
        ["Hon.", "Hon."],
        ["Br.", "Br."],
        ["Sr.", "Sr."],
        ["Rep.", "Rep."],
        ["Sen.", "Sen."],
        ["other", "Other"]
      ]
    end

    def self.state_options_for_select
      [
        ["Select One...","none"],
        ["Alabama","AL"],
        ["Alaska","AK"],

        ["American Samoa","AS"],
        ["Arizona","AZ"],
        ["Arkansas","AR"],
        ["California","CA"],
        ["Colorado","CO"],
        ["Connecticut","CT"],

        ["Delaware","DE"],
        ["D.C.","DC"],
        ["Florida","FL"],
        ["Georgia","GA"],
        ["Guam","GU"],
        ["Hawaii","HI"],

        ["Idaho","ID"],
        ["Illinois","IL"],
        ["Indiana","IN"],
        ["Iowa","IA"],
        ["Kansas","KS"],
        ["Kentucky","KY"],

        ["Louisiana","LA"],
        ["Maine","ME"],
        ["Maryland","MD"],
        ["Massachusetts","MA"],
        ["Michigan","MI"],
        ["Minnesota","MN"],

        ["Mississippi","MS"],
        ["Missouri","MO"],
        ["Montana","MT"],
        ["Nebraska","NE"],
        ["Nevada","NV"],
        ["New Hampshire","NH"],

        ["New Jersey","NJ"],
        ["New Mexico","NM"],
        ["New York","NY"],
        ["North Carolina","NC"],
        ["North Dakota","ND"],
        ["Ohio","OH"],

        ["Oklahoma","OK"],
        ["Oregon","OR"],
        ["Pennsylvania","PA"],
        ["Puerto Rico","PR"],
        ["Rhode Island","RI"],
        ["South Carolina","SC"],

        ["South Dakota","SD"],
        ["Tennessee","TN"],
        ["Texas","TX"],
        ["Utah","UT"],
        ["Vermont","VT"],
        ["Virgin Islands","VI"],

        ["Virginia","VA"],
        ["Washington","WA"],
        ["West Virginia","WV"],
        ["Wisconsin","WI"],
        ["Wyoming","WY"],
        ["Alberta","AB"],

        ["British Columbia","BC"],
        ["Manitoba","MB"],
        ["Newfoundland","NF"],
        ["New Brunswick","NB"],
        ["Nova Scotia","NS"],
        ["Northwest Territories","NT"],

        ["Nunavut","NU"],
        ["Ontario","ON"],
        ["Prince Edward Island","PE"],
        ["Quebec","QC"],
        ["Saskatchewan","SK"],
        ["Yukon Territory","YT"],

        ["Other","ot"]
      ]
    end
    
    def self.time_options_for_select(selected = nil)
      options = ''
      6.upto(23) do |h|
        options << "<option value=\"#{h}\"#{' selected' if selected==h}>#{h > 12 ? h-12 : (h.zero? ?12 : h)}:00 #{h < 12 ? 'AM' : 'PM'}</option>"
        options << "<option value=\"#{h + 0.5}\"#{' selected' if selected==h + 0.5}>#{h > 12 ? h-12 : (h.zero? ? 12 : h)}:30 #{h < 12 ? 'AM' : 'PM'}</option>"
      end
      0.upto(5) do |h|
        options << "<option value=\"#{h}\"#{' selected' if selected==h}>#{h > 12 ? h-12 : (h.zero? ?12 : h)}:00 #{h < 12 ? 'AM' : 'PM'}</option>"
        options << "<option value=\"#{h + 0.5}\"#{' selected' if selected==h + 0.5}>#{h > 12 ? h-12 : (h.zero? ? 12 : h)}:30 #{h < 12 ? 'AM' : 'PM'}</option>"
      end
      options
    end
    
    def self.title_options_for_select 
      [
        ["Select One...","none"],
        ["Mr.", "Mr."], 
        ["Mrs.", "Mrs."], 
        ["Ms.", "Ms."], 
        ["Rabbi", "Rabbi"],
        ["Fr.", "Fr."],
        ["Rev.", "Rev."],
        ["Hon.", "Hon."],
        ["Br.", "Br."],
        ["Sr.", "Sr."],
        ["Rep.", "Rep."],
        ["Sen.", "Sen."],
        ["other", "other"],
      ]
    end
  end
end
