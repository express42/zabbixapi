class ZabbixApi
  class Proxies < Basic

    def method_name
      "proxy"
    end

    def indentify
      "host"
    end

    def delete(data)
      result = @client.api_request(:method => "proxy.delete", :params => data)
      result.empty? ? nil : result['proxyids'][0].to_i
    end

    def isreadable(data)
      result = @client.api_request(:method => "proxy.isreadable", :params => data)
    end

    def iswritable(data)
      result = @client.api_request(:method => "proxy.iswritable", :params => data)
    end

  end
end

