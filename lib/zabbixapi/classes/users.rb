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

    # Add media to users using Zabbix API
    #
    # @param data [Hash] Needs to include userids and media to mass add media to users
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id (media)
    def add_medias(data)
      result = @client.api_request(
        :method => 'user.addMedia',
        :params => {
          :users => data[:userids].map { |t| {:userid => t} },
          :medias => data[:media],
        }
      )
      result ? result['mediaids'][0].to_i : nil
    end

    # Update media for users using Zabbix API
    #
    # @param data [Hash] Needs to include userids and media to mass update media for users
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id (user)
    def update_medias(data)
      result = @client.api_request(
        :method => 'user.updateMedia',
        :params => {
          :users => data[:userids].map { |t| {:userid => t} },
          :medias => data[:media],
        }
      )
      result ? result['userids'][0].to_i : nil
    end
  end
end
