# Extends <tt>ActionController::Routing::RouteSet</tt> to automatically add the theme routes
module ThemeSupport
  module Routing
    module RouteSet
      module MapperExt
        def self.included(base)
          base.alias_method_chain :initialize, :themes
        end

        def initialize_with_themes(set)
          initialize_without_themes(set)
          named_route 'theme_images', "/themes/:theme/images/:filename", :controller=>'theme', :action=>'images', :requirements => {:filename => /.*/}
          named_route 'theme_stylesheets', "/themes/:theme/stylesheets/:filename", :controller=>'theme', :action=>'stylesheets', :requirements => {:filename => /.*/}
          named_route 'theme_javascripts', "/themes/:theme/javascript/:filename", :controller=>'theme', :action=>'javascript', :requirements => {:filename => /.*/}
          connect "/themes/*whatever", :controller=>'theme', :action=>'error'
        end
      end
    end
  end
end

