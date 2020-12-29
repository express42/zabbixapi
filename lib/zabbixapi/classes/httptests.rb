class ZabbixApi
  class HttpTests < Basic
    # The method name used for interacting with HttpTests via Zabbix API
    #
    # @return [String]
    def method_name
      'httptest'
    end

    # The id field name used for identifying specific HttpTest objects via Zabbix API
    #
    # @return [String]
    def identify
      'name'
    end

    # The default options used when creating HttpTest objects via Zabbix API
    #
    # @return [Hash]
    def default_options
      {
        hostid: nil,
        name: nil,
        steps: []
      }
    end

    # Get or Create HttpTest object using Zabbix API
    #
    # @param data [Hash] Needs to include name and hostid to properly identify HttpTests via Zabbix API
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

    # Create or update HttpTest object using Zabbix API
    #
    # @param data [Hash] Needs to include name and hostid to properly identify HttpTests via Zabbix API
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id
    def create_or_update(data)
      httptestid = get_id(name: data[:name], hostid: data[:hostid])
      httptestid ? update(data.merge(httptestid: httptestid)) : create(data)
    end
  end
end
