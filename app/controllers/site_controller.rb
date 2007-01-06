class SiteController < ApplicationController
  before_filter :login_required
  access_control :DEFAULT => 'admin'

  def load_fixtures
    require 'active_record/fixtures'
    ['event_groups.yml', 'events.yml', 'reports.yml'].each do |fixture_file|
      Fixtures.create_fixtures(File.join('test','fixtures'), File.basename(fixture_file, '.*'))
    end
    redirect_to home_url
  end
end
