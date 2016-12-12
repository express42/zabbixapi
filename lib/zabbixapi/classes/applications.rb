class ZabbixApi
  class Applications < Basic

    API_PARAMETERS = %w(applicationids groupids hostids inherited itemids templated templateids selectItems)

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

    def create_or_update(data)
      applicationid = get_id(:name => data[:name], :hostid => data[:hostid])
      applicationid ? update(data.merge(:applicationid => applicationid)) : create(data)
    end

  end
end
