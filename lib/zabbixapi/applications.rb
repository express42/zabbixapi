class ZabbixApi
  class Applications < Basic

    def api_method_name
      "application"
    end

    def api_identify
      "name"
    end

    def create(data)
      create_array(data)
    end

    def delete(data)
      delete_array(data)
    end

    def get_full_data(data)
      get_full_data_filter(data)
    end

  end
end
