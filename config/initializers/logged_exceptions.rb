if 'production' == RAILS_ENV
  require 'application' unless Object.const_defined?(:ApplicationController)
  LoggedExceptionsController.class_eval do
    # set the same session key as the app
    session :session_key => '_daysofaction_session_id'
    
    # include any custom auth modules you need
    include AuthenticatedSystem
    
    before_filter :login_required
    
    # optional, sets the application name for the rss feeds
    self.application_name = "Revent"
    
    protected
      # only allow admins
      # this obviously depends on how your auth system works
      def authorized?
        current_user.admin?
      end
      
      # assume app's login required doesn't use http basic
      def login_required_with_basic
        respond_to do |accepts|
          # alias_method_chain will alias the app's login_required to login_required_without_basic
          accepts.html { login_required_without_basic }
          
          # access_denied_with_basic_auth is defined in LoggedExceptionsController
          # get_auth_data returns back the user/password pair
          accepts.rss do
            access_denied_with_basic_auth unless self.current_user = User.authenticate(*get_auth_data)
          end
        end
      end
      
      alias_method_chain :login_required, :basic
  end
end
