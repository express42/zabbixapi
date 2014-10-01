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

    def update
      request(data, "usermacro.update", "hostmacroids")
    end

    def update_global
      request(data, "usermacro.updateglobal", "globalmacroids")
    end

    private
      def request(data, method, result_key)
        result = @client.api_request(:method => method, :params => data)
        result.empty? ? nil : result[result_key][0].to_i
      end

  end
end
