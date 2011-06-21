module Zabbix
  class ZabbixApi

    def add_graph(graph)
      message = {
        'method' => 'graph.create',
        'params' => graph
      }

      response = send_request(message)

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

      response = send_request(message)

      unless ( response.empty? ) then
        result = response[0]['graphid']
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

      response = send_request(message)

      unless ( response.empty? ) then
        result = {}

        response.each() do |graph|
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
