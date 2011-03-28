module Zabbix
  class ZabbixApi

    def add_graph(graph)
      message = {
        'method' => 'graph.create',
        'params' => graph
      }

      responce = send_request(message)

      puts "DEBUG: #{responce.inspect}"

      return 0
    end

    def get_graph_id(host_id, graph_name)
      
      message = {
        'method' => 'graph.get',
        'params' => {
          'filter' => {
            'name' => graph_name,
            'hostid' => host_id
          }
        }
      }

      responce = send_request(message)

      unless ( responce.empty? ) then
        result = responce[0]['graphid']
      else
        result = nil
      end
    end

    def get_graphs(host_id)

      message = {
        'method' => 'graph.get',
        'params' => {
          'extendoutput' => '1',
          'filter' => {
            'hostid' => host_id
          }
        }
      }

      responce = send_request(message)

      unless ( responce.empty? ) then
        result = {}

        responce.each() do |graph|
          graph_id = graph['graphid']
          graph_name = graph['name']

          result[graph_id] = graph_name
        end
      else
        result = nil
      end

      return result
    end
  end
end
