class ZabbixApi
  class Applications < Basic
    # The method name used for interacting with Applications via Zabbix API
    #
    # @return [String]
    def method_name
      'application'
    end

    # The id field name used for identifying specific Application objects via Zabbix API
    #
    # @return [String]
    def identify
      'name'
    end

    # Get or Create Application object using Zabbix API
    #
    # @param data [Hash] Needs to include name and hostid to properly identify Applications via Zabbix API
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id
    def get_or_create(data)
      log "[DEBUG] Call get_or_create with parameters: #{data.inspect}"

      unless (id = get_id(name: data[:name], hostid: data[:hostid]))
        id = create(data)
      end
      id
    end

    # Create or update Application object using Zabbix API
    #
    # @param data [Hash] Needs to include name and hostid to properly identify Applications via Zabbix API
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id
    def create_or_update(data)
      applicationid = get_id(name: data[:name], hostid: data[:hostid])
      applicationid ? update(data.merge(applicationid: applicationid)) : create(data)
    end
  end
end
