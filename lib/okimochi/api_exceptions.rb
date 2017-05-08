module Okimochi
  class APIExceptions
    StatusCode = Struct.new("StatusCode", :message, :code, :status)

    RESCUE_RESPONSES = {
      "ActiveRecord::RecordNotFound" => StatusCode.new("Not Found", :not_found, 404),
      "ActiveRecord::RecordInvalid" => StatusCode.new("Validation Failed", :validation_failed, 422),
      "ActiveRecord::RecordNotSaved" => StatusCode.new("Validation Failed", :validation_failed, 422),
    }

    def call(env)
      request = ActionDispatch::Request.new(env)
      exception = env["action_dispatch.exception"]
      build_response(request, exception)
    end

    private

      def build_response(request, exception)
        content_type = request.formats.first
        status_code = status_code(exception)
        record = record(exception)
        body = ErrorRepresentation.new(status_code.message, status_code.code, model: record).as_json.to_json

        [status_code.status, { "Content-Type" => "#{content_type}; charset=#{ActionDispatch::Response.default_charset}", "Content-Length" => body.bytesize.to_s }, [body]]
      end

      def status_code(exception)
        class_name = exception.class.name
        if status_code = RESCUE_RESPONSES[class_name]
          return status_code
        end

        code = ActionDispatch::ExceptionWrapper.rescue_responses[class_name]
        status = ActionDispatch::ExceptionWrapper.status_code_for_exception(class_name)
        message = Rack::Utils::HTTP_STATUS_CODES[status]
        StatusCode.new(message, code, status)
      end

      def record(exception)
        attrs = [:record, :model]
        if attr = attrs.select { |attr| exception.respond_to?(attr) }.first
          exception.public_send(attr)
        else
          nil
        end
      end
  end
end
