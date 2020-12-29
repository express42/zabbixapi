class ZabbixApi
  class Screens < Basic
    # extracted from frontends/php/include/defines.inc.php
    # SCREEN_RESOURCE_GRAPH => 0,
    # SCREEN_RESOURCE_SIMPLE_GRAPH => 1,
    # SCREEN_RESOURCE_MAP => 2,
    # SCREEN_RESOURCE_PLAIN_TEXT => 3,
    # SCREEN_RESOURCE_HOSTS_INFO => 4,
    # SCREEN_RESOURCE_TRIGGERS_INFO => 5,
    # SCREEN_RESOURCE_SERVER_INFO => 6,
    # SCREEN_RESOURCE_CLOCK => 7,
    # SCREEN_RESOURCE_SCREEN => 8,
    # SCREEN_RESOURCE_TRIGGERS_OVERVIEW => 9,
    # SCREEN_RESOURCE_DATA_OVERVIEW => 10,
    # SCREEN_RESOURCE_URL => 11,
    # SCREEN_RESOURCE_ACTIONS => 12,
    # SCREEN_RESOURCE_EVENTS => 13,
    # SCREEN_RESOURCE_HOSTGROUP_TRIGGERS => 14,
    # SCREEN_RESOURCE_SYSTEM_STATUS => 15,
    # SCREEN_RESOURCE_HOST_TRIGGERS => 16

    # The method name used for interacting with Screens via Zabbix API
    #
    # @return [String]
    def method_name
      'screen'
    end

    # The id field name used for identifying specific Screen objects via Zabbix API
    #
    # @return [String]
    def identify
      'name'
    end

    # Delete Screen object using Zabbix API
    #
    # @param data [String, Array] Should include id's of the screens to delete
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id
    def delete(data)
      result = @client.api_request(method: 'screen.delete', params: [data])
      result.empty? ? nil : result['screenids'][0].to_i
    end

    # Get or Create Screen object for Host using Zabbix API
    #
    # @param data [Hash] Needs to include screen_name and graphids to properly identify Screens via Zabbix API
    # @raise [ApiError] Error returned when there is a problem with the Zabbix API call.
    # @raise [HttpError] Error raised when HTTP status from Zabbix Server response is not a 200 OK.
    # @return [Integer] Zabbix object id
    def get_or_create_for_host(data)
      screen_name = data[:screen_name]
      graphids = data[:graphids]
      screenitems = []
      hsize = data[:hsize] || 3
      valign = data[:valign] || 2
      halign = data[:halign] || 2
      rowspan = data[:rowspan] || 1
      colspan = data[:colspan] || 1
      height = data[:height] || 320 # default 320
      width = data[:width] || 200 # default 200
      vsize = data[:vsize] || [1, (graphids.size / hsize).to_i].max
      screenid = get_id(name: screen_name)

      unless screenid
        # Create screen
        graphids.each_with_index do |graphid, index|
          screenitems << {
            resourcetype: 0,
            resourceid: graphid,
            x: (index % hsize).to_i,
            y: (index % graphids.size / hsize).to_i,
            valign: valign,
            halign: halign,
            rowspan: rowspan,
            colspan: colspan,
            height: height,
            width: width
          }
        end

        screenid = create(
          name: screen_name,
          hsize: hsize,
          vsize: vsize,
          screenitems: screenitems
        )
      end
      screenid
    end
  end
end
