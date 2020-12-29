class ZabbixApi
  class Maintenance < Basic
    # The method name used for interacting with Maintenances via Zabbix API
    #
    # @return [String]
    def method_name
      'maintenance'
    end

    # The id field name used for identifying specific Maintenance objects via Zabbix API
    #
    # @return [String]
    def identify
      'name'
    end
  end
end
