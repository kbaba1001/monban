module Monban
  module Constraints
    # Rails route constraint for signed in users
    class SignedIn
      def initialize(scope = Monban.config.session_default_scope)
        @scope = scope
      end

      # Checks to see if the constraint is matched by having a user signed in
      #
      # @param request [Rack::Request] A rack request
      def matches?(request)
        warden = request.env["warden"]
        warden && warden.authenticated?(@scope)
      end
    end
  end
end
