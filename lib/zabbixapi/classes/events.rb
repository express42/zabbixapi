class ZabbixApi
  class Events < Basic
    # The method name used for interacting with Events via Zabbix API
    #
    # @return [String]
    def method_name
      'event'
    end

    # The id field name used for identifying specific Event objects via Zabbix API
    #
    # @return [String]
    def identify
      'name'
    end
  end
end
