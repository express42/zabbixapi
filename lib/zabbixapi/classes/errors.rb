class ZabbixApi
  class BaseError < RuntimeError
    attr_accessor :response, :error, :error_message

    def initialize(message, response = nil)
      super(message)
      @response = response

      set_error! if @response
    end

  private

    def set_error!
      @error = @response.try(:[], :error)
      @error_message = @error.try(:[], :message) + ': ' + @error.try(:[], :data)
    end
  end

  class ApiError < BaseError
  end

  class HttpError < BaseError
  end
end
