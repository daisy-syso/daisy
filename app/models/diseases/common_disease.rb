class Diseases::CommonDisease < ActiveRecord::Base
	has_and_belongs_to_many :diseases

	class << self
    include Filterable

    define_nested_filter_method :filters do
      self.all
    end
  end
end
