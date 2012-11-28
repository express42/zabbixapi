class ZabbixApi
  class Screens < Basic

    def api_method_name
      "screen"
    end

    def api_identify
      "name"
    end

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


    # Return info about screen
    # 
    # * *Args*    : 
    #   - +data+ -> Hash with :name => "Screen name"
    # * *Returns* :
    #   - Hash with screen info
    def get_full_data(data)
      result = @client.api_request(:method => "screen.get", :params => {:search => data, :output => "extend"})
      result.empty? ? [] : result
    end


    # Create screen all graphs for host
    #
    # * *Args*    :
    #   - +data+ -> Hash with :host=> "hostname", :graphsid => [], [:hsize, :vsize]
    # * *Returns* :
    #   - Nil or Integer
    def get_or_create_for_host(data)
      screen_name = data[:host].to_s + "_graphs"
      graphids = data[:graphids]
      screenitems = []
      hsize = data[:hsize] || 3
      vsize = data[:vsize] || ((graphids.size/hsize) + 1).to_i
      screenid = get_id(:name => screen_name)
      unless screenid
        # Create screen
        graphids.each_with_index do |graphid, index|
          screenitems << {
            :resourcetype => 0,
            :resourceid => graphid,
            :x => (index % hsize).to_i,
            :y => (index % graphids.size/hsize).to_i
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
