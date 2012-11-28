class ZabbixApi
  class Graphs < Basic


    def api_method_name
      "graph"
    end

    def api_identify
      "name"
    end

    def create(data)
      create_array(data)
    end

    def delete(data)
      result = @client.api_request(:method => "graph.delete", :params => [data])
      case @client.api_version
        when "1.3"
          result ? 1 : nil  #return "true" or "false" for this api version
        else
          result.empty? ? nil : result['graphids'][0].to_i
      end
    end

    def get_full_data(data)
      get_full_data_filter()
    end

    def get_ids_by_host(data)
      ids = []
      result = @client.api_request(:method => "graph.get", :params => {:filter => {:host => data[:host]}, :output => "extend"})
      result.each do |graph|
        ids << graph['graphid']
      end
      ids
    end

    def get_items(data)
      @client.api_request(:method => "graphitem.get", :params => { :graphids => [data], :output => "extend" } )
    end

    def get_id(data)
      result = @client.api_request(:method => "graph.get", :params => {:filter => {:name=> data[:name]}, :output => "extend"})
      graphid = nil
      result.each { |graph| graphid = graph['graphid'].to_i if graph['name'] == data[:name] }
      graphid
    end

    def create_or_update(data)
      graphid = get_id(:name => data[:name], :templateid => data[:templateid])
      graphid ? _update(data.merge(:graphid => graphid)) : create(data)
    end

    def _update(data)
      data.delete(:name)
      update(data)
    end

    def get_or_create(data)
      unless graphid = get_id(:name => data[:name], :templateid => data[:templateid])
        graphid = create(data)
      end
      graphid
    end

    def update(data)
      case @client.api_version
        when "1.2"
          @client.api_request(:method => "graph.update", :params => data) 
        else
          result = @client.api_request(:method => "graph.update", :params => data)
          result.empty? ? nil : result['graphids'][0].to_i
      end
    end

  end
end
