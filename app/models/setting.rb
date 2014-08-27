class Setting < ActiveRecord::Base
  serialize :value

  class << self
    def get key, default = nil
      find_by(name: key) || default
    end
  end
end
