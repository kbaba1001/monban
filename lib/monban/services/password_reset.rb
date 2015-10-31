module Monban
  module Services
    # Password reset service. Updates the password on a User
    # @since 0.0.15
    class PasswordReset
      # Initialize service
      #
      # @param user [User] A user object
      # @param new_password [String] The new undigested password for a user
      def initialize user, new_password, scope
        @user = user
        @new_password = new_password
        @scope = scope
      end

      # Perform the service.
      def perform
        field = Monban.config(@scope).user_token_store_field
        digested_password = Monban.hash_token(@new_password, @scope)
        @user[field] = digested_password
      end
    end
  end
end
