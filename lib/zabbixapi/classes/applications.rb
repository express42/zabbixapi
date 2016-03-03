class ZabbixApi
  class Applications

    API_PARAMETERS = %w(applicationids groupids hostids inherited itemids templated templateids selectItems)

    def initialize(client)
      @client = client
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

    def get_or_create(data)
      unless (appid = get_id(data))
        appid = create(data)
      end
      appid
    end

    def destroy(data)
      delete(data)
    end

    def get_full_data(data)
      filter_params = {}
      request_data = data.dup # Duplicate data, as we modify it. Otherwise methods that use data after calling get_full_data (such as get_id) will fail.

      request_data.each { |key, value| filter_params[key] = request_data.delete(key) unless API_PARAMETERS.include?(key) }
      @client.api_request(:method => "application.get", :params => request_data.merge({:filter => filter_params, :output => "extend"}))
    end

    def get_id(data)
      result = get_full_data(data)
      applicationid = nil
      result.each { |app| applicationid = app['applicationid'].to_i if app['name'] == data[:name] }
      applicationid
    end

  end
end
