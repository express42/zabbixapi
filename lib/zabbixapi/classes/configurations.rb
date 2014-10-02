class ZabbixApi
  class Configurations < Basic

    def array_flag
      true
    end

    def method_name
      "configuration"
    end

    def indentify
      "host"
    end

    # Export configuration data as a serialized string
    # * *Args*    :
    # see available parameters: https://www.zabbix.com/documentation/2.2/manual/api/reference/configuration/export
    # * *Returns* :
    #   - String
    def export(data)
      @client.api_request(:method => "configuration.export", :params => data)
    end

    # Import configurations data from a serialized string
    # * *Args*    :
    # see available parameters: https://www.zabbix.com/documentation/2.2/manual/api/reference/configuration/import
    # * *Returns* :
    #   - Boolean
    def import(data)
      @client.api_request(:method => "configuration.import", :params => data)
    end

  end
end

