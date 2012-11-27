class ZabbixApi
  class Users

    def initialize(client)
      @client = client
    end

    def create(data)
      result = @client.api_request(:method => "user.create", :params => data)
      result ? result['userids'][0].to_i : nil
    end

    def add(data)
      create(data)
    end

    def delete(data)
      result = @client.api_request(:method => "user.delete", :params => [:userid => data])
      result ? result['userids'][0].to_i : nil
    end

    def get_full_data(data)
      @client.api_request(
        :method => "user.get", 
        :params => {
          :filter => {
            :name => data[:name]
          },
          :output => "extend"
          }
        )
    end

    def get(data)
      get_full_data(data)
    end

    def create_or_update(data)
      userid = get_id(:name => data[:name])
      userid ? update(data.merge(:userid => userid)) : create(data)
    end

    def add_medias(data)
      result = @client.api_request(
        :method => "user.addMedia", 
        :params => {
          :users => data[:userids].map { |t| {:userid => t} },
          :medias => data[:media]
        }
      )
      result ? result['userids'][0].to_i : nil
    end

    def get_id(data)
      result = get_full_data(data)
      userid = nil
      result.each { |usr| userid = usr['userid'].to_i if usr['name'] == data[:name] }
      userid
    end

    def update(data)
      result = @client.api_request(:method => "user.update", :params => data)
      result ? result['userids'][0].to_i : nil
    end

  end
end
