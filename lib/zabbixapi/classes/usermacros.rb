class ZabbixApi
  class Usermacros < Basic
    def indentify
      "macro"
    end

    def method_name
      "usermacro"
    end

    def create(data)
      request(data, "usermacro.create", "hostmacroids")
    end

    def create_global(data)
      request(data, "usermacro.createglobal", "globalmacroids")
    end

    def delete(data)
      request(data, "usermacro.delete", "hostmacroids")
    end

    def delete_global(data)
      request(data, "usermacro.deleteglobal", "globalmacroids")
    end

    def update(data)
      request(data, "usermacro.update", "hostmacroids")
    end

    def update_global(data)
      request(data, "usermacro.updateglobal", "globalmacroids")
    end

    def get_or_create(data)
      log "[DEBUG] Call get_or_create with parameters: #{data.inspect}"

      unless (id = request({:macro => data[:macro], :hostid => data[:hostid]}, "usermacro.get", "hostmacroid"))
        id = create(data)
      end
      id
    end

    def create_or_update(data)
      hostmacroid = request({:macro => data[:macro], :hostid => data[:hostid]}, "usermacro.get", "hostmacroid")
      hostmacroid ? update(data.merge(:hostmacroid => hostmacroid)) : create(data)
    end

    private
      def request(data, method, result_key)
        result = @client.api_request(:method => method, :params => data)
        result.empty? ? nil : result[result_key][0].to_i
      end

  end
end
