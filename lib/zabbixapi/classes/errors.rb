class ZabbixApi

  class BaseError < RuntimeError
    attr_accessor :response

    def initialize(message, response = nil)
      super(message)
      self.response = response
    end
  end

  class ApiError < BaseError
  end

  class HttpError < BaseError

  end

  class SocketError < BaseError
  end

end
