class ZabbixApi
  class Screens

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

    def initialize(client)
      @client = client
      @screen_default_options = {
        :vsize => 3
      }
    end

    # Create screen
    #
    # * *Args*    :
    #   - +data+ -> Hash with :name => "Screen name", hsize (rows) and vsize (columns) and array :screenitems => []
    #   screenitems contains :resourcetype (0 - graph), :resourcetypeid (id item) and :x and :y position
    # * *Returns* :
    #   - Nil or Integer
    def create(data)
      result = @client.api_request(:method => "screen.create", :params => data)
      result ? result['screenids'][0].to_i : nil
    end

    # Create screen
    # Synonym create
    def add(data)
      create(data)
    end

    # Update screen
    #
    # * *Args*    :
    #   - +data+ -> Hash with :screenid => [ "screenid" ]
    # * *Returns* :
    #   - Nil or Integer
    def update(data)
      result = @client.api_request(:method => "screen.update", :params => data)
      result ? result['screenids'][0].to_i : nil      
    end

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

    # Return screenid
    # 
    # * *Args*    : 
    #   - +data+ -> Hash with :name => "Screen name"
    # * *Returns* :
    #   - Nil or Integer
    def get_id(data)
      result = get_full_data(data)
      screenid = nil
      result.each { |screen| screenid = screen['screenid'].to_i if screen['name'] == data[:name] }
      screenid
    end

    # Delete screen
    #
    # * *Args*    :
    #   - +data+ -> Hash with :params => [screenid]
    # * *Returns* :
    #   - Nil or Integer
    def delete(data)
      result = @client.api_request(:method => "screen.delete", :params => data)
      result.empty? ? nil : result['screenids'][0].to_i
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
