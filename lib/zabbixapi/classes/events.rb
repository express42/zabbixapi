class ZabbixApi
  class Events < Basic
    # The method name used for interacting with Events via Zabbix API
    #
    # @return [String]
    def method_name
      'events'
    end

    # The id field name used for identifying specific Event objects via Zabbix API
    #
    # @return [String]
    def indentify
      'name'
    end
  end
end
