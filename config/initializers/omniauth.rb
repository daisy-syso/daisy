Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer
  provider :weibo, Setting['weibo.key'], Setting['weibo.secret'] rescue nil
end
