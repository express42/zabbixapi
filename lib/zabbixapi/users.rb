class ZabbixApi
  class Users < Basic

    def api_method_name
      "user"
    end

    def api_identify
      "name"
    end

    def delete(data)
      delete_array_sym(data)
    end

    def get_full_data(data)
      get_full_data_filter(data)
    end

    def add_medias(data)
      result = @client.api_request(
        :method => "user.addMedia", 
        :params => {
          :users => data[:userids].map { |t| {:userid => t} },
          :medias => data[:media]
        }
      )
      result ? result['userids'][0].to_i : nil
    end

  end
end
