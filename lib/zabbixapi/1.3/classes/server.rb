class ZabbixApi
  class Server

    attr :version

    def initialize(client)
      @client = client
      @version = @client.api_request(:method => "apiinfo.version", :params => {})
    end

  end
end
