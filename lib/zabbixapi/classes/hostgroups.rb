class ZabbixApi
  class HostGroups < Basic
    # The method name used for interacting with HostGroups via Zabbix API
    #
    # @return [String]
    def method_name
      'hostgroup'
    end

    # The id field name used for identifying specific HostGroup objects via Zabbix API
    #
    # @return [String]
    def identify
      'name'
    end

    # The key field name used for HostGroup objects via Zabbix API
    #
    # @return [String]
    def key
      'groupid'
    end
  end
end
