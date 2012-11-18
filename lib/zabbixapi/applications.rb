class ZabbixApi
  class Applications

    def initialize(options = {})
      @client = Client.new(options)
      @options = options
    end

    def create(data)
      result = @client.api_request(:method => "application.create", :params => [data])
      result.empty? ? nil : result['applicationids'][0].to_i
    end

    def add(data)
      create(data)
    end

    def delete(data)
      result = @client.api_request(:method => "application.delete", :params => [data])
      result.empty? ? nil : result['applicationids'][0].to_i
    end

    def destroy(data)
      delete(data)
    end

    def get_full_data(data)
      @client.api_request(:method => "application.get", :params => {:filter => data, :output => "extend"})
    end

    def get_id(data)
      result = get_full_data(data)
      result.empty? ? nil : result[0]['applicationid'].to_i
    end

  end
end