Qiniu.establish_connection! :access_key => Settings.qiniu.ak,
                            :secret_key => Settings.qiniu.sk

$put_policy = Qiniu::Auth::PutPolicy.new(Settings.qiniu.qiniu_bucket, nil, nil, Settings.qiniu.expires_in)

$qiniu_token = Qiniu::Auth.generate_uptoken($put_policy)