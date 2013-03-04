class ZabbixApi
  class Screens < Basic

    # extracted from frontends/php/include/defines.inc.php
    #SCREEN_RESOURCE_GRAPH => 0,
    #SCREEN_RESOURCE_SIMPLE_GRAPH => 1,
    #SCREEN_RESOURCE_MAP => 2,
    #SCREEN_RESOURCE_PLAIN_TEXT => 3,
    #SCREEN_RESOURCE_HOSTS_INFO => 4,
    #SCREEN_RESOURCE_TRIGGERS_INFO => 5,
    #SCREEN_RESOURCE_SERVER_INFO => 6,
    #SCREEN_RESOURCE_CLOCK => 7,
    #SCREEN_RESOURCE_SCREEN => 8,
    #SCREEN_RESOURCE_TRIGGERS_OVERVIEW => 9,
    #SCREEN_RESOURCE_DATA_OVERVIEW => 10,
    #SCREEN_RESOURCE_URL => 11,
    #SCREEN_RESOURCE_ACTIONS => 12,
    #SCREEN_RESOURCE_EVENTS => 13,
    #SCREEN_RESOURCE_HOSTGROUP_TRIGGERS => 14,
    #SCREEN_RESOURCE_SYSTEM_STATUS => 15,
    #SCREEN_RESOURCE_HOST_TRIGGERS => 16

    def method_name
      "screen"
    end

    def indentify
      "name"
    end

    def delete(data)
      screen_name = data[:screen_name]
      screen_id   = data[:screen_id]

      unless screen_name.nil?
        unless screen_name.instance_of?(Array)
          screen_id = get_id(:name => screen_name)
        else
          screen_id = []
          screen_name.each do |name|
            screen_id << get_id(:name => name)
          end
        end
      end

      unless screen_id.instance_of?(Array)
        screen_id = [screen_id, screen_id]
      end

      result = @client.api_request(:method => "screen.delete", :params => screen_id)
      result.empty? ? nil : result['screenids'][0].to_i
    end

    def get_or_create_for_host(data)
      screen_name = data[:screen_name]
      graphids = data[:graphids]
      screenitems = []
      hsize = data[:hsize] || 3
      valign = data[:valign] || 2
      halign = data[:halign] || 2
      rowspan = data[:rowspan] || 0
      colspan = data[:colspan] || 0
      height = data[:height] || 320 # default 320
      width = data[:width] || 200 # default 200
      vsize = data[:vsize] || (graphids.size/hsize).to_i
      screenid = get_id(:name => screen_name)

      if ((graphids.size/hsize) / 2) == 0
        vsize = data[:vsize] || (graphids.size/hsize).to_i
      else
        vsize = data[:vsize] || ((graphids.size/hsize)+1).to_i
      end

      unless screenid
        # Create screen
        graphids.each_with_index do |graphid, index|
          screenitems << {
            :resourcetype => 0,
            :resourceid => graphid,
            :x => (index % hsize).to_i,
            :y => (index % graphids.size/hsize).to_i,
            :valign => valign,
            :halign => halign,
            :rowspan => rowspan,
            :colspan => colspan,
            :height => height,
            :width => width
          }
        end
        screenid = create(
          :name => screen_name,
          :hsize => hsize,
          :vsize => vsize,
          :screenitems => screenitems
        )
      end
      screenid
    end

  end
end
