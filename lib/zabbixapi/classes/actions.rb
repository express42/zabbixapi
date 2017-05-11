class ZabbixApi
  class Actions < Basic
    # The method name used for interacting with Actions via Zabbix API
    #
    # @return [String]
    def method_name
      'action'
    end

    # The id field name used for identifying specific Action objects via Zabbix API
    #
    # @return [String]
    def indentify
      'name'
    end
  end
end
