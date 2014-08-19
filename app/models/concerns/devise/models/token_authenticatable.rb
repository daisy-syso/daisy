module Devise
  module Models
    module TokenAuthenticatable
      extend ActiveSupport::Concern

      included do
        before_save :ensure_authentication_token
      end

      def ensure_authentication_token
        self.authentication_token ||= generate_authentication_token
      end

      private

      def generate_authentication_token
        loop do
          token = Devise.friendly_token
          break token unless self.class.exists?(authentication_token: token)
        end
      end

    end
  end
end