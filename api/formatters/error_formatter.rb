module ErrorFormatter
  def self.call(message, backtrace, options, env)
    puts message
    puts backtrace
    { error: message, success: false }.to_json
  end
end