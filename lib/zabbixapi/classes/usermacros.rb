class ZabbixApi
  class Usermacros < Basic
    def indentify
      "macro"
    end

    def method_name
      "usermacro"
    end

    def get_id(data)
      log "[DEBUG] Call get_id with parameters: #{data.inspect}"

      # symbolize keys if the user used string keys instead of symbols
      data = symbolize_keys(data) if data.key?(indentify)
      # raise an error if indentify name was not supplied 
      name = data[indentify.to_sym]
      raise ApiError.new("#{indentify} not supplied in call to get_id") if name == nil

      result = request(data, "usermacro.get", "hostmacroid")

      result.length > 0 && result[0].key?("hostmacroid") ? result[0]["hostmacroid"].to_i : nil
    end

    def get_id_global(data)
      log "[DEBUG] Call get_id_global with parameters: #{data.inspect}"

      # symbolize keys if the user used string keys instead of symbols
      data = symbolize_keys(data) if data.key?(indentify)
      # raise an error if indentify name was not supplied 
      name = data[indentify.to_sym]
      raise ApiError.new("#{indentify} not supplied in call to get_id") if name == nil

      result = request(data, "usermacro.get", "globalmacroid")

      result.length > 0 && result[0].key?("globalmacroid") ? result[0]["globalmacroid"].to_i : nil
    end

    def get_full_data(data)
      log "[DEBUG] Call get_full_data with parameters: #{data.inspect}"

      request(data, "usermacro.get", "hostmacroid")
    end

    def get_full_data_global(data)
      log "[DEBUG] Call get_full_data_global with parameters: #{data.inspect}"

      request(data, "usermacro.get", "globalmacroid")
    end

    def create(data)
      request(data, "usermacro.create", "hostmacroids")
    end

    def create_global(data)
      request(data, "usermacro.createglobal", "globalmacroids")
    end

    def delete(data)
      data_delete = [data]
      request(data_delete, "usermacro.delete", "hostmacroids")
    end

    def delete_global(data)
      data_delete = [data]
      request(data_delete, "usermacro.deleteglobal", "globalmacroids")
    end

    def update(data)
      request(data, "usermacro.update", "hostmacroids")
    end

    def update_global(data)
      request(data, "usermacro.updateglobal", "globalmacroids")
    end

    def get_or_create(data)
      log "[DEBUG] Call get_or_create with parameters: #{data.inspect}"

      unless (id = get_id(:macro => data[:macro], :hostid => data[:hostid]))
        id = create(data)
      end
      id
    end

    def get_or_create_global(data)
      log "[DEBUG] Call get_or_create_global with parameters: #{data.inspect}"

      unless (id = get_id_global(:macro => data[:macro], :hostid => data[:hostid]))
        id = create_global(data)
      end
      id
    end

    def create_or_update(data)
      hostmacroid = get_id(:macro => data[:macro], :hostid => data[:hostid])
      hostmacroid ? update(data.merge(:hostmacroid => hostmacroid)) : create(data)
    end

    def create_or_update_global(data)
      hostmacroid = get_id_global(:macro => data[:macro], :hostid => data[:hostid])
      hostmacroid ? update_global(data.merge(:globalmacroid => globalmacroid)) : create_global(data)
    end

    private
      def request(data, method, result_key)
        # Zabbix has different result formats for gets vs updates
        if method.include?(".get")
          if result_key.include?("global")
            result = @client.api_request(:method => method, :params => { :globalmacro => true, :filter => data })
          else
            result = @client.api_request(:method => method, :params => { :filter => data })
          end
        else
          result = @client.api_request(:method => method, :params => data)

          result.key?(result_key) && result[result_key].length > 0 ? result[result_key][0].to_i : nil
        end
      end

  end
end
