class ZabbixApi
  class Basic

    def initialize(client)
      @client = client
    end

    def method_name
      raise "Can't call method_name here"
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
      raise "Can't call indentify here"
    end

    def array_flag
      false
    end

  end
end
