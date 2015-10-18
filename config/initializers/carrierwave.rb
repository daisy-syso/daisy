::CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = Settings.qiniu.ak
  config.qiniu_secret_key    = Settings.qiniu.sk
  config.qiniu_bucket        = "syso"
  config.qiniu_bucket_domain = "syso.qiniudn.com"
end