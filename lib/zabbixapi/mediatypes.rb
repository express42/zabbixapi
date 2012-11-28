class ZabbixApi
  class Mediatypes < Basic

    #:description => "",  #Name
    #:type => 0,          #0 - Email, 1 - External script, 2 - SMS, 3 - Jabber, 100 - EzTexting
    #:smtp_server => "", 
    #:smtp_helo   => "",
    #:smtp_email  => "",  #Email address of Zabbix server
    #:exec_path => "",    #Name of external script
    #:gsm_modem => "",    #Serial device name of GSM modem
    #:username  => "",    #Jabber user name used by Zabbix server
    #:passwd    => "",   #Jabber password used by Zabbix server

    def api_method_name
      "mediatype"
    end

    def api_identify
      "name"
    end

    def delete(data)
      delete_array(data)
    end

    def get_full_data(data)
      @client.api_request(
        :method => "mediatype.get", 
        :params => {
          :search => {:description => data[:description]},
          :output => "extend"
          }
        )
    end

  end
end
