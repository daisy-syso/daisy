class Diseases::Symptom < ActiveRecord::Base
  has_and_belongs_to_many :diseases

  class << self
    include Filterable

    define_filter_method :filters, :disease_type do
      self.all
    end
  end

end
