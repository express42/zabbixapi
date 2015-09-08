class ZabbixApi
  class Basic

    def initialize(client)
      @client = client
    end

    def method_name
      raise ApiError.new("Can't call method_name here")
    end

    def default_options
      {}
    end

    def keys
      key + "s"
    end

    def key
      method_name + "id"
    end

    def indentify
      raise ApiError.new("Can't call indentify here")
    end

  end
end
