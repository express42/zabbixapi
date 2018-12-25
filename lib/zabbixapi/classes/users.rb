class ZabbixApi
  class Users < Basic
    # The method name used for interacting with Users via Zabbix API
    #
    # @return [String]
    def method_name
      'user'
    end

    # The keys field name used for User objects via Zabbix API
    #
    # @return [String]
    def keys
      'userids'
    end

    # The key field name used for User objects via Zabbix API
    #
    # @return [String]
    def key
      'userid'
    end

    # The id field name used for identifying specific User objects via Zabbix API
    #
    # @return [String]
    def indentify
      'alias'
    end

  end
end
