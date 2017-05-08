require_relative "api_exceptions"

module Okimochi
  class Exceptions
    def call(env)
      request = ActionDispatch::Request.new(env)
      if json?(request)
        Okimochi::APIExceptions.new.call(env)
      else
        ActionDispatch::PublicExceptions.new(Rails.public_path).call(env)
      end
    end

    private

      def json?(request)
        request.formats.first&.to_sym == :json
      end
  end
end
