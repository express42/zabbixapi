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

    def create_or_update(data)
      httptestid = get_id(:name => data[:name], :hostid => data[:hostid])
      httptestid ? update(data.merge(:httptestid => httptestid)) : create(data)
    end
  end
end
