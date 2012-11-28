class ZabbixApi
  class Triggers < Basic

    def api_method_name
      "trigger"
    end

    def api_identify
      "description"
    end

    def delete(data)
      delete_array(data)
    end

    def create(data)
      create_array(data)
    end

    def get_full_data(data)
      get_full_data_filter(data)
    end

  end
end
