class ZabbixApi
  class Hostinterfaces < Basic
    def array_flag
      true
    end

    def method_name
      "hostinterface"
    end

    def indentify
      "interfaceid"
    end

    def key
      "interfaceid"
    end
  end
end