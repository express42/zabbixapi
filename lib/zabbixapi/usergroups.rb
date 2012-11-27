class ZabbixApi
  class Usergroups

    def initialize(options = {})
      @client = Client.new(options)
      @options = options
    end

    # Create UserGroup
    #
    # * *Args*    :
    #   - +data+ -> Hash with :name => "UserGroup"
    # * *Returns* :
    #   - Nil or Integer
    def create(data)
      result = @client.api_request(:method => "usergroup.create", :params => data)
      result ? result['usrgrpids'][0].to_i : nil
    end

    # Add UserGroup
    # Synonym create
    def add(data)
      create(data)
    end

    # Delete UserGroup
    #
    # * *Args*    :
    #   - +data+ -> Array with usrgrpids
    # * *Returns* :
    #   - Nil or Integer
    def delete(data)
      result = @client.api_request(:method => "usergroup.delete", :params => data)
      result ? result['usrgrpids'][0].to_i : nil
    end

    # Destroy UserGroup
    # Synonym delete
    def destroy(data)
      delete(data)
    end

    # Get UserGroup info
    #
    # * *Args*    :
    #   - +data+ -> Hash with :name => "UserGroup"
    # * *Returns* :
    #   - Nil or Integer
    def get_full_data(data)
      @client.api_request(
        :method => "usergroup.get", 
        :params => {
          :filter => [data[:name]],
          :output => "extend"
          }
        )
    end

    def get(data)
      get_full_data(data)
    end

    # Return usrgrpid
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :name => "UserGroup"
    # * *Returns* :
    #   - Nil or Integer 
    def get_id(data)
      result = get_full_data(data)
      usrgrpid = nil
      result.each { |usr| usrgrpid = usr['usrgrpid'].to_i if usr['name'] == data[:name] }
      usrgrpid
    end

    # Return usrgrpid
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :name => "UserGroup"
    # * *Returns* :
    #   - Integer
    def get_or_create(data)
      usrgrpid = get_id(data)
      if usrgrpid.nil?
        usrgrpid = create(data)
      end
      usrgrpid
    end

    # Set read permisssion for usrgrp on some hostgroup
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :usrgrpids => id, :hostgroupids => []
    # * *Returns* :
    #   - Integer
    def set_perm_read(data)
      result = @client.api_request(
        :method => "usergroup.massAdd", 
        :params => {
          :usrgrpids => [data[:usrgrpids]],
          :rights => data[:hostgroupids].map { |t| {:permission => 2, :id => t} }
        }
      )
      result ? result['usrgrpids'][0].to_i : nil
    end

    # Update usergroup, add user
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :usrgrpids => id, :userids => []
    # * *Returns* :
    #   - Integer
    def add_user(data)
      result = @client.api_request(
        :method => "usergroup.massAdd", 
        :params => {
          :usrgrpids => data[:usrgrpids],
          :userids => data[:userids]
        }
      )
      result ? result['usrgrpids'][0].to_i : nil
    end

  end
end
