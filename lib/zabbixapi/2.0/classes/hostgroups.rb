class ZabbixApi
  class HostGroups < Basic

    def array_flag
      true
    end

    def method_name
      "hostgroup"
    end

    def indentify
      "name"
    end

    def key
      "groupid"
    end

    # def delete(data)
    #   result = @client.api_request(:method => "hostgroup.delete", :params => [data])
    #   result.empty? ? nil : result['groupids'][0].to_i
    # end

  end
end
