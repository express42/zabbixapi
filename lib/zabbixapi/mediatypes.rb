class ZabbixApi
  class Mediatypes

    def initialize(client)
      @client = client
      @default_mediatype_options = {
        :description => "",  #Name
        :type => 0,          #0 - Email, 1 - External script, 2 - SMS, 3 - Jabber, 100 - EzTexting
        :smtp_server => "", 
        :smtp_helo   => "",
        :smtp_email  => "",  #Email address of Zabbix server
        :exec_path => "",    #Name of external script
        :gsm_modem => "",    #Serial device name of GSM modem
        :username  => "",    #Jabber user name used by Zabbix server
        :passwd    => ""     #Jabber password used by Zabbix server
      }
    end

    # Create MediaType
    #
    # * *Args*    :
    #   - +data+ -> Hash with :description => "MediaGroup" and mediatype options
    # * *Returns* :
    #   - Nil or Integer
    def create(data)
      result = @client.api_request(:method => "mediatype.create", :params => data)
      result ? result['mediatypeids'][0].to_i : nil
    end

    # Add MediaType
    # Synonym create
    def add(data)
      create(data)
    end

    # Delete MediaType
    #
    # * *Args*    :
    #   - +data+ -> Array with mediatypeids
    # * *Returns* :
    #   - Nil or Integer
    def delete(data)
      result = @client.api_request(:method => "mediatype.delete", :params => [data])
      result ? result['mediatypeids'][0].to_i : nil
    end

    # Destroy MediaType
    # Synonym delete
    def destroy(data)
      delete(data)
    end

    # Get MediaType info
    #
    # * *Args*    :
    #   - +data+ -> Hash with :description => "MediaType"
    # * *Returns* :
    #   - Nil or Integer
    def get_full_data(data)
      @client.api_request(
        :method => "mediatype.get", 
        :params => {
          :search => {:description => data[:description]},
          :output => "extend"
          }
        )
    end

    def get(data)
      get_full_data(data)
    end

    # Return MediaTypeid
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :description => "MediaType"
    # * *Returns* :
    #   - Nil or Integer 
    def get_id(data)
      result = get_full_data(data)
      mediatypeid = nil
      result.each { |mt| mediatypeid = mt['mediatypeid'].to_i if mt['description'] == data[:description] }
      mediatypeid
    end

    # Return MediaTypeid
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :description => "MediaType"
    # * *Returns* :
    #   - Nil or Integer
    def update(data)
      result = @client.api_request(:method => "mediatype.update", :params => data)
      result.empty? ? nil : result['mediatypeids'][0].to_i
    end

    # Return MediaTypeid
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :name => "UserGroup"
    # * *Returns* :
    #   - Integer
    def create_or_update(data)
      mediatypeid = get_id(:description => data[:description], :mediatypeid => data[:mediatypeid])
      mediatypeid ? update(data.merge(:mediatypeid => mediatypeid)) : create(data)      
    end

  end
end
