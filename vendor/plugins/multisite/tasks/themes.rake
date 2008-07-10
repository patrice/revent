require 'sass'

desc "Creates the cached (public) theme folders"
task :theme_create_cache do

  for theme in Dir.glob("#{RAILS_ROOT}/themes/*")
    theme_name = theme.split( File::Separator )[-1]
    puts "Creating #{RAILS_ROOT}/public/themes/#{theme_name}"
    
    FileUtils.mkdir_p "#{RAILS_ROOT}/public/themes/#{theme_name}"

    # convert sass files in themes directory to css prior to copy
    sass2css_dir = "#{theme}/stylesheets/sass/css"
    Dir["#{theme}/stylesheets/sass/*.sass"].each do |f|
      FileUtils.mkdir_p(sass2css_dir) unless File.exists?(sass2css_dir)
      css = Sass::Engine.new(File.new(f, "r").read).render
      css_filename = f.gsub(/(.+)\/(.+).sass$/, '\1/css/\2.css')
      File.open(css_filename, "w") {|f| f << css}
    end
    FileUtils.cp_r("#{theme}/stylesheets", "#{RAILS_ROOT}/public/themes/#{theme_name}/stylesheets", :verbose => true) if File.exists?("#{theme}/stylesheets")
    #FileUtils.rm_rf(sass2css_dir)

    FileUtils.cp_r("#{theme}/images", "#{RAILS_ROOT}/public/themes/#{theme_name}/images", :verbose => true) if File.exists?("#{theme}/images")
    FileUtils.cp_r("#{theme}/javascript", "#{RAILS_ROOT}/public/themes/#{theme_name}/javascript", :verbose => true) if File.exists?("#{theme}/javascript")
    FileUtils.cp_r("#{theme}/preview.png", "#{RAILS_ROOT}/public/themes/#{theme_name}/preview.png", :verbose => true) if File.exists?("#{theme}/preview.png")
  end
end

desc "Removes the cached (public) theme folders"
task :theme_remove_cache do
  puts "Removing #{RAILS_ROOT}/public/themes"
  FileUtils.rm_r "#{RAILS_ROOT}/public/themes", :force => true
end

desc "Updates the cached (public) theme folders"
task :theme_update_cache => [:theme_remove_cache, :theme_create_cache]
