class ZabbixApi
  class Triggers

    def initialize(options = {})
      @client = Client.new(options)
      @options = options
    end

    def create(data)
      result = @client.api_request(:method => "trigger.create", :params => [data])
      result.empty? ? nil : result['triggerids'][0].to_i
    end

    def add(data)
      create(data)
    end

    def delete(data)
      result = @client.api_request(:method => "trigger.delete", :params => [data])
      result.empty? ? nil : result['triggerids'][0].to_i
    end

    def destroy(data)
      delete(data)
    end

    def update(data)
      result = @client.api_request(:method => "trigger.update", :params => data)
      result.empty? ? nil : result['triggerid'][0].to_i
    end

    def get_full_data(data)
      @client.api_request(:method => "trigger.get", :params => {:filter => data, :output => "extend"})
    end

    def get_id(data)
      result = get_full_data(data)
      result.empty? ? nil : result[0]['triggerid'].to_i
    end

  end
end