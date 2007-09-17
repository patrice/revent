module DemocracyInAction
  class Cron
    #lame

    cattr_accessor :config

    def self.import_supporter_campaign(site_id = nil, ago = 1.day.ago)
      Site.current = Site.find(site_id) if site_id
      @config = config || DemocracyInAction::Config.new(File.join(Site.current_config_path, 'democracyinaction-config.yml'))
      api = DemocracyInAction::API.new(@config)
      supporter_campaigns = api.get 'supporter_campaign', 'where' => "supporter_campaign.Date_Created > '#{ago.to_s(:db)}'"
      supporter_campaigns.collect do |sc|
        user = User.find_or_initialize_by_site_id_and_email Site.current.id, sc['Email']
        unless user.crypted_password || (user.password && user.password_confirmation)
          password = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
          user.password = user.password_confirmation = password
        end 
        user.first_name = sc['First_Name']
        user.last_name = sc['Last_Name']
        user.save
        politicians_ids = sc['person_legislator_IDS'].split(',')
        event = DemocracyInActionObject.find_by_table_and_key('campaign', sc['campaign_KEY']).associated
        politicians_ids.collect do |p|
          invite = PoliticianInvite.new :politician_id => p
          invite.event = event
          invite.user = user
          invite.invite_type = 'email'
          invite.build_democracy_in_action_object :table => 'supporter_campaign', :key => sc['key'], :local => sc
          invite
        end
      end.flatten
    end
  end
end
