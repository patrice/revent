# Extending <tt>ActionView::Base</tt> to support rendering themes
#
module ActionView
   # <tt>ThemeError</tt> is thrown when <tt>force_liquid</tt> is true, and 
   # a <tt>.liquid</tt> template isn't found.
   class ThemeError < StandardError
   end
   
   # Extending <tt>ActionView::Base</tt> to support rendering themes
   class Base
      alias_method :__render_file, :render_file

      # Overrides the default <tt>Base#render_file</tt> to allow theme-specific views
      def render_file(template_path, use_full_path = true, local_assigns = {})
        return __render_file(template_path, use_full_path, local_assigns) if @controller.class.superclass == ActionMailer::Base
        search_path = [
          "../themes/#{controller.current_theme}/views",       # for components
          "../../themes/#{controller.current_theme}/views",    # for normal views
          "../../themes/#{controller.current_theme}",          # for layouts
          "../../../themes/#{controller.current_theme}/views", # for mailer views
          ".",                                                 # fallback
          ".."                                                 # Mailer fallback
        ]
        if use_full_path
          template_path_without_extension, template_extension_explicit = path_and_extension(template_path)
          local_assigns['active_theme'] = controller.current_theme unless controller.current_theme.nil? 
          search_path.each do |prefix|
            begin
              template_extension = template_extension_explicit || pick_template_extension("#{prefix}/#{template_path_without_extension}")
              if File.exists?(full_template_path("#{prefix}/#{template_path_without_extension}", template_extension))
                # Prevent .rhtml (or any other template type) if force_liquid == true
                raise ThemeError.new("Template '#{template_path}' must be a liquid document") if controller.force_liquid_template && template_extension.to_s != 'liquid' && prefix != '.'                  

                return __render_file("#{prefix}/#{template_path}", use_full_path, local_assigns)
              end
            rescue ActionView::ActionViewError => err
               next
            rescue ThemeError => err
              # Should it raise an exception, or just call 'next' and revert to
              # the default template?
              raise err
            end
          end
          raise ActionViewError, "No rhtml, rxml, or delegate template found for #{template_path}"
        else
          __render_file(template_path, use_full_path, local_assigns)
        end
      end
   end
end
