class SocialSecurities::SocialSecurityType < ActiveRecord::Base
  has_many :social_securities

  class << self
    include Filterable

    define_filter_method :filters do
      self.all
    end
  end

end
