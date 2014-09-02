module Exclamationable
  extend ActiveSupport::Concern

  module ClassMethods
    def define_exclamation_dot_method method
      class_eval <<-EOM
        def #{method}! *args
          #{method}(*args).save(validate: false)
        end
      EOM
    end

    def define_exclamation_and_method method
      class_eval <<-EOM
        def #{method}! *args
          #{method}(*args)
          save(validate: false)
        end
      EOM
    end

    def define_exclamation_dot_methods *methods
      methods.each do |method|
        define_exclamation_dot_method method
      end
    end

    def define_exclamation_and_methods *methods
      methods.each do |method|
        define_exclamation_and_method method
      end
    end
  end
end
