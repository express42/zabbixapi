class ZabbixApi
  class HostGroups

    def initialize(client)
      @client = client
    end

    def create(data)
      result = @client.api_request(:method => "hostgroup.create", :params => [data])
      result.empty? ? nil : result['groupids'][0].to_i
    end

    def add(data)
      create(data)
    end

    def delete(data)
      result = @client.api_request(:method => "hostgroup.delete", :params => [:groupid => data])
      result.empty? ? nil : result['groupids'][0].to_i
    end

    def destroy(data)
      delete(data)
    end

    def get_or_create(data)
      unless hostgroupid = get_id(data)
        hostgroupid = update(data)
      end
      hostgroupid
    end

    def get_full_data(data)
      case @client.api_version 
        when "1.2"
          @client.api_request(:method => "hostgroup.get", :params => {:filter => data, :output => "extend"})
        else
          @client.api_request(:method => "hostgroup.get", :params => {:filter => data, :output => "extend"})
      end
    end

    # Return all hostgroups
    # 
    # * *Returns* :
    #   - Hash with {"Hostgroup1" => "id1", "Hostgroup2" => "id2"}
    def all
      result = {}
      @client.api_request(:method => "hostgroup.get", :params => {:output => "extend"}).each do |hostgrp|
        result[hostgrp['name']] = hostgrp['groupid']
      end
      result
    end

    def get_id(data)
      result = get_full_data(data)
      hostgroupid = nil
      result.each { |hgroup| hostgroupid = hgroup['groupid'].to_i if hgroup['name'] == data[:name] }
      hostgroupid
    end

  end
end
