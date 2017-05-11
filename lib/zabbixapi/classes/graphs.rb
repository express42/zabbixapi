class ZabbixApi
  class Graphs < Basic
    # The method name used for interacting with Graphs via Zabbix API
    #
    # @return [String]
    def method_name
      'graph'
    end

    # The id field name used for identifying specific Graph objects via Zabbix API
    #
    # @return [String]
    def indentify
      'name'
    end

    # Get full/extended Graph data from Zabbix API
    #
    # @param data [Hash] Should include object's id field name (indentify) and id value
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Hash]
    def get_full_data(data)
      log "[DEBUG] Call get_full_data with parametrs: #{data.inspect}"

      @client.api_request(
        :method => "#{method_name}.get",
        :params => {
          :search => {
            indentify.to_sym => data[indentify.to_sym],
          },
          :output => 'extend',
        }
      )
    end

    # Get Graph ids for Host from Zabbix API
    #
    # @param data [Hash] Should include host value to query for matching graphs
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Array] Returns array of Graph ids
    def get_ids_by_host(data)
      ids = []
      graphs = {}

      result = @client.api_request(
        :method => 'graph.get',
        :params => {
          :filter => {
            :host => data[:host],
          },
          :output => 'extend',
        }
      )

      result.each do |graph|
        num  = graph['graphid']
        name = graph['name']
        graphs[name] = num
        filter = data[:filter]

        if filter.nil?
          ids.push(graphs[name])
        elsif /#{filter}/ =~ name
          ids.push(graphs[name])
        end
      end

      ids
    end

    # Get Graph Item object using Zabbix API
    #
    # @param data [Hash] Needs to include graphids to properly identify Graph Items via Zabbix API
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Hash]
    def get_items(data)
      @client.api_request(
        :method => 'graphitem.get',
        :params => {
          :graphids => [data],
          :output => 'extend',
        }
      )
    end

    # Get or Create Graph object using Zabbix API
    #
    # @param data [Hash] Needs to include name and templateid to properly identify Graphs via Zabbix API
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id
    def get_or_create(data)
      log "[DEBUG] Call get_or_create with parameters: #{data.inspect}"

      unless (id = get_id(:name => data[:name], :templateid => data[:templateid]))
        id = create(data)
      end

      id
    end

    # Create or update Graph object using Zabbix API
    #
    # @param data [Hash] Needs to include name and templateid to properly identify Graphs via Zabbix API
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id
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
