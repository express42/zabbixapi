class ZabbixApi
  class Graphs < Basic

    def array_flag
      true
    end

    def method_name
      "graph"
    end

    def indentify
      "name"
    end

    def get_full_data(data)
      log "[DEBUG] Call get_full_data with parametrs: #{data.inspect}"

      @client.api_request(
        :method => "#{method_name}.get",
        :params => {
          :search => {
            indentify.to_sym => data[indentify.to_sym]
          },
          :output => "extend"
        }
      )
    end

    def get_ids_by_host(data)
      ids = []
      graphs = Hash.new
      result = @client.api_request(:method => "graph.get", :params => {:filter => {:host => data[:host]}, :output => "extend"})
      result.each do |graph|
        num  = graph['graphid']
        name = graph['name']
        graphs[name] = num
        filter = data[:filter]

        unless filter.nil?
          if /#{filter}/ =~ name
            ids.push(graphs[name])
          end
        else
            ids.push(graphs[name])
        end
      end
      ids
    end

    def get_items(data)
      @client.api_request(:method => "graphitem.get", :params => { :graphids => [data], :output => "extend" } )
    end

    def create_or_update(data)
      graphid = get_id(:name => data[:name], :templateid => data[:templateid])
      graphid ? _update(data.merge(:graphid => graphid)) : create(data)
    end

    def _update(data)
      data.delete(:name)
      update(data)
    end

  end
end
