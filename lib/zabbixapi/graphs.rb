class ZabbixApi
  class Graphs

    def initialize(options = {})
      @client = Client.new(options)
      @options = options
    end

    def create(data)
      result = @client.api_request(:method => "graph.create", :params => [data])
      result.empty? ? nil : result['graphids'][0].to_i
    end

    def add(data)
      create(data)
    end

    def delete(data)
      result = @client.api_request(:method => "graph.delete", :params => [data])
      case @client.api_version
        when "1.3"
          result ? 1 : 0  #return "true" or "false" for this api version
        else
          result.empty? ? nil : result['graphids'][0].to_i
      end
    end

    def destroy(data)
      delete(data)
    end

    def get_full_data(data)
      @client.api_request(:method => "graph.get", :params => {:search => {:name => data}, :output => "extend"})
    end

    def get_id(data)
      result = @client.api_request(:method => "graph.get", :params => {:filter => {:name=> data[:name]}, :output => "extend"})
      result.empty? ? nil : result[0]['graphid'].to_i
    end

    def update(data)
      result = @client.api_request(:method => "graph.update", :params => data)
      result.empty? ? nil : result['graphids'][0].to_i
    end

  end
end