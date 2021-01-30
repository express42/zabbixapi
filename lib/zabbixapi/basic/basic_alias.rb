class ZabbixApi
  class Basic
    # Get Zabbix object data from API by id
    #
    # @param data [Hash] Should include object's id field name (identify) and id value
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Hash]
    def get(data)
      get_full_data(data)
    end

    # Add new Zabbix object using API create
    #
    # @param data [Hash]
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] The object id if a single object is created
    # @return [Boolean] True/False if multiple objects are created
    def add(data)
      create(data)
    end

    # Destroy Zabbix object using API delete
    #
    # @param data [Hash] Should include object's id field name (identify) and id value
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] The object id if a single object is deleted
    # @return [Boolean] True/False if multiple objects are deleted
    def destroy(data)
      delete(data)
    end

    def method_name; end
  end
end
