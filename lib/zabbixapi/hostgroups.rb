class ZabbixApi
  class HostGroups < Basic

    def api_method_name
      "hostgroup"
    end

    def api_identify
      "name"
    end

    def api_key
      "groupid"
    end

    def create(data)
      create_array(data)
    end

    def delete(data)
      delete_array_sym(data)
    end

    def get_full_data(data)
      get_full_data_filter(data)
    end

  end
end
