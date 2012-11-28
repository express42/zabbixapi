class ZabbixApi
  class Usergroups < Basic

    def api_method_name
      "usergroup"
    end

    def api_identify
      "name"
    end

    def api_key
      "usrgrpid"
    end

    def get_full_data(data)
      get_full_data_filter_array(data)
    end

    def set_perms(data)
      permission = data[:permission] || 2 
      result = @client.api_request(
        :method => "usergroup.massAdd", 
        :params => {
          :usrgrpids => [data[:usrgrpid]],
          :rights => data[:hostgroupids].map { |t| {:permission => permission, :id => t} }
        }
      )
      result ? result['usrgrpids'][0].to_i : nil
    end

    def add_user(data)
      result = @client.api_request(
        :method => "usergroup.massAdd", 
        :params => {
          :usrgrpids => data[:usrgrpids],
          :userids => data[:userids]
        }
      )
      result ? result['usrgrpids'][0].to_i : nil
    end

  end
end
