module Zabbix
  class ZabbixApi

    def add_graph(graph)
      message = {
          'method' => 'graph.create',
          'params' => graph
      }
      response = send_request(message)
      response.empty? ? nil : response['graphids'][0]
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
      response.empty? ? nil : response[0]['graphid']
    end

    def add_or_get_graph(host_id, graph)
      unless g_id = get_graph_id(host_id, graph['name'])
        g_id = add_graph(graph)
      end
      return g_id
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
      if response.empty?
        result = nil
      else
        result = {}
        response.each() do |graph|
          graph_id = graph['graphid']
          graph_name = graph['name']
          result[graph_id] = graph_name
        end
      end
      return result
    end

  end
end
