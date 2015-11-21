desc 'API Routes'

namespace :api do
  task routes: :environment do
    DaisyAPI.routes.each do |api|
      if api.route_method
        method = api.route_method.center(10)
        if api.route_path.present? && api.route_path =~ /json/
          path = "/api#{api.route_path}"
          puts "#{method}#{path}       #{api.as_json["options"]["description"]}"
        end
      end
    end
  end
end