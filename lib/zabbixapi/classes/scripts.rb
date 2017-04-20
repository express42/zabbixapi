class ZabbixApi
  class Scripts < Basic

    def method_name
      "script"
    end

    def indentify
      "name"
    end

    def execute(data)
      @client.api_request(
        :method => "script.execute",
        :params => {
          :scriptid => data[:scriptid],
          :hostid => data[:hostid]
        }
      )
    end

    def getscriptsbyhost(data)
      @client.api_request(:method => "script.getscriptsbyhosts", :params => data)
    end

  end
end
