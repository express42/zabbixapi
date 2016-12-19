class ZabbixApi
  class HttpTests < Basic

    def method_name
      "httptest"
    end

    def indentify
      "name"
    end

    def default_options
      {
        :hostid => nil,
        :name => nil,
        :steps => []
      }
    end

    def get_or_create(data)
      log "[DEBUG] Call get_or_create with parameters: #{data.inspect}"

      unless (id = get_id(:name => data[:name], :hostid => data[:hostid]))
        id = create(data)
      end
      id
    end

    def create_or_update(data)
      httptestid = get_id(:name => data[:name], :hostid => data[:hostid])
      httptestid ? update(data.merge(:httptestid => httptestid)) : create(data)
    end
  end
end
