class ZabbixApi
  class Users < Basic

    def method_name
      "user"
    end

    def keys
      "userids"
    end

    def key 
      "userid"
    end

    def indentify
      "name"
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
