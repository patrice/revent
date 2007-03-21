module DemocracyInAction
  module Helpers
    def self.state_options_for_select
      {
        "none" => "Select One...",
        "AL" => "Alabama",
        "AK" => "Alaska",

        "AS" => "American Samoa",
        "AZ" => "Arizona",
        "AR" => "Arkansas",
        "CA" => "California",
        "CO" => "Colorado",
        "CT" => "Connecticut",

        "DE" => "Delaware",
        "DC" => "D.C.",
        "FL" => "Florida",
        "GA" => "Georgia",
        "GU" => "Guam",
        "HI" => "Hawaii",

        "ID" => "Idaho",
        "IL" => "Illinois",
        "IN" => "Indiana",
        "IA" => "Iowa",
        "KS" => "Kansas",
        "KY" => "Kentucky",

        "LA" => "Louisiana",
        "ME" => "Maine",
        "MD" => "Maryland",
        "MA" => "Massachusetts",
        "MI" => "Michigan",
        "MN" => "Minnesota",

        "MS" => "Mississippi",
        "MO" => "Missouri",
        "MT" => "Montana",
        "NE" => "Nebraska",
        "NV" => "Nevada",
        "NH" => "New Hampshire",

        "NJ" => "New Jersey",
        "NM" => "New Mexico",
        "NY" => "New York",
        "NC" => "North Carolina",
        "ND" => "North Dakota",
        "OH" => "Ohio",

        "OK" => "Oklahoma",
        "OR" => "Oregon",
        "PA" => "Pennsylvania",
        "PR" => "Puerto Rico",
        "RI" => "Rhode Island",
        "SC" => "South Carolina",

        "SD" => "South Dakota",
        "TN" => "Tennessee",
        "TX" => "Texas",
        "UT" => "Utah",
        "VT" => "Vermont",
        "VI" => "Virgin Islands",

        "VA" => "Virginia",
        "WA" => "Washington",
        "WV" => "West Virginia",
        "WI" => "Wisconsin",
        "WY" => "Wyoming",
        "AB" => "Alberta",

        "BC" => "British Columbia",
        "MB" => "Manitoba",
        "NF" => "Newfoundland",
        "NB" => "New Brunswick",
        "NS" => "Nova Scotia",
        "NT" => "Northwest Territories",

        "NU" => "Nunavut",
        "ON" => "Ontario",
        "PE" => "Prince Edward Island",
        "QC" => "Quebec",
        "SK" => "Saskatchewan",
        "YT" => "Yukon Territory",

        "ot" => "Other"
      }
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
  end
end
