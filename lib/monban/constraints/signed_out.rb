module Monban
  module Constraints
    # Rails route constraint for signed out users
    class SignedOut
      def initialize(scope = nil)
        @scope = scope
      end

      # Checks to see if the constraint is matched by not having a user signed in
      #
      # @param request [Rack::Request] A rack request
      def matches?(request)
        warden = request.env["warden"]
        warden && warden.unauthenticated?(@scope)
      end
    end
  end
end
