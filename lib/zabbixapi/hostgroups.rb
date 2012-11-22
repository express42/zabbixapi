class ZabbixApi
  class HostGroups

    def initialize(options = {})
      @client = Client.new(options)
      @options = options
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

    def create_or_update(data)
      hostgroupid = get_id(:name => data[:name])
      hostgroupid ? update(data.merge(:groupid => hostgroupid)) : create(data)
    end

    def get_full_data(data)
      case @client.api_version 
        when "1.2"
          @client.api_request(:method => "hostgroup.get", :params => {:filter => data, :output => "extend"})
        else
          @client.api_request(:method => "hostgroup.get", :params => {:filter => data, :output => "extend"})
      end
    end

    def get_id(data)
      result = get_full_data(data)
      hostgroupid = nil
      result.each { |hgroup| hostgroupid = hgroup['groupid'].to_i if hgroup['name'] == data[:name] }
      hostgroupid
    end

  end
end