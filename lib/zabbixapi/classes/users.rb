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
      "alias"
    end

    def add_medias(data)
      result = @client.api_request(
        :method => "user.addMedia",
        :params => {
          :users => data[:userids].map { |t| {:userid => t} },
          :medias => data[:media]
        }
      )
      result ? result['mediaids'][0].to_i : nil
    end

    def update_medias(data)
      result = @client.api_request(
        :method => "user.updateMedia",
        :params => {
          :users => data[:userids].map { |t| {:userid => t} },
          :medias => data[:media]
        }
      )
      result ? result['userids'][0].to_i : nil
    end

  end
end
