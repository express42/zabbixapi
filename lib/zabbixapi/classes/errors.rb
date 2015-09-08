class ZabbixApi

  class BaseError < RuntimeError
    attr_accessor :response

    def initialize(message, response = nil)
      super(message)
      @response = response
    end
  end

  class ApiError < BaseError
  end

  class HttpError < BaseError
  end

end
