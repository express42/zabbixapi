class ZabbixApi
  class Triggers

    def initialize(client)
      @client = client
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
      result.empty? ? nil : result['triggerids'][0].to_i
    end

    def create_or_update(data)
      triggerid = get_id(:description => data[:description], :templateid => data[:templateid])
      triggerid ? update(data.merge(:triggerid => triggerid)) : create(data)
    end

    def get_full_data(data)
      @client.api_request(:method => "trigger.get", :params => {:filter => data, :output => "extend"})
    end

    def get_id(data)
      result = get_full_data(data)
      triggerid = nil
      result.each { |template| triggerid = template['triggerid'].to_i if template['name'] == data[:name] }
      triggerid
    end

  end
end
