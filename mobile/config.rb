###
# Reverse Proxy
###

require 'rack/reverse_proxy'

use Rack::ReverseProxy do 
  # Set :preserve_host to true globally (default is true already)
  reverse_proxy_options :preserve_host => true

  # Forward the path /test* to http://example.com/test*
  reverse_proxy '/api', 'http://localhost:3000/api'

  # # Forward the path /foo/* to http://example.com/bar/*
  # reverse_proxy /^\/foo(\/.*)$/, 'http://example.com/bar$1', :username => 'name', :password => 'basic_auth_secret'
end

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

page "/templates/*", :layout => false

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

activate :bower

configure :development do
  set :debug_assets, true

  # Reload the browser automatically whenever files change
  activate :livereload
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  set :http_prefix, "/mobiles/"
end

after_build do |builder|
  Dir["#{config[:build_dir]}/templates/lists/**/*.html"].each do |file|
    af = File.open "#{config[:build_dir]}/templates/list.html", "a"
    File.open file do |f|
      path = file[/templates\/lists\/.*/]
      af.puts
      af.puts "<script type=\"text/ng-template\" id=\"#{path}\">"
      af.puts f.read
      af.puts "</script>"
    end
    af.close
  end
end

activate :deploy do |deploy|
  deploy.method   = :sftp
  deploy.host     = '101.69.181.251'
  deploy.port     = 22
  deploy.path     = '/var/www/daisy/shared/public/mobiles'
  # Optional Settings
  deploy.user     = 'ubuntu' # no default
  # deploy.password = 'secret' # no default
end
