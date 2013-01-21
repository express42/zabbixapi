class ZabbixApi

  class BaseError < RuntimeError
  end

  class ApiError < BaseError
  end

  class HttpError < BaseError
  end

  class SocketError < BaseError
  end

end