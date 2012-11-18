class ZabbixApi
  class Server

    attr :version

    def initialize(options = {})
      @client = Client.new(options)
      @version = @client.api_request(:method => "apiinfo.version", :params => {})
    end

  end
end