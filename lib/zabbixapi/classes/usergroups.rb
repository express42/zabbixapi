class ZabbixApi
  class Usergroups < Basic
    # The method name used for interacting with Usergroups via Zabbix API
    #
    # @return [String]
    def method_name
      'usergroup'
    end

    # The key field name used for Usergroup objects via Zabbix API
    #
    # @return [String]
    def key
      'usrgrpid'
    end

    # The id field name used for identifying specific Usergroup objects via Zabbix API
    #
    # @return [String]
    def indentify
      'name'
    end

    # Set permissions for usergroup using Zabbix API
    #
    # @param data [Hash] Needs to include usrgrpids and hostgroupids along with permissions to set
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id (usergroup)
    def set_perms(data)
      permission = data[:permission] || 2
      result = @client.api_request(
        :method => 'usergroup.massAdd',
        :params => {
          :usrgrpids => [data[:usrgrpid]],
          :rights => data[:hostgroupids].map { |t| {:permission => permission, :id => t} },
        }
      )
      result ? result['usrgrpids'][0].to_i : nil
    end

    # Add users to usergroup using Zabbix API
    #
    # @param data [Hash] Needs to include userids and usrgrpids to mass add users to groups
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id (usergroup)
    def add_user(data)
      result = @client.api_request(
        :method => 'usergroup.massAdd',
        :params => {
          :usrgrpids => data[:usrgrpids],
          :userids => data[:userids],
        }
      )
      result ? result['usrgrpids'][0].to_i : nil
    end

    # Update users in usergroups using Zabbix API
    #
    # @param data [Hash] Needs to include userids and usrgrpids to mass update users in groups
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id (usergroup)
    def update_users(data)
      result = @client.api_request(
        :method => 'usergroup.massUpdate',
        :params => {
          :usrgrpids => data[:usrgrpids],
          :userids => data[:userids],
        }
      )
      result ? result['usrgrpids'][0].to_i : nil
    end
  end
end
