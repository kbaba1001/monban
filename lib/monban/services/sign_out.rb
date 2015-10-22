module Monban
  module Services
    # Sign out service. Signs the user out via warden
    # @since 0.0.15
    class SignOut
      # Initialize service
      #
      # @param warden [Warden] warden
      def initialize(warden, scope = nil)
        @warden = warden
        @scope = scope
      end

      # Perform the service
      def perform
        @warden.logout(@scope)
      end
    end
  end
end
