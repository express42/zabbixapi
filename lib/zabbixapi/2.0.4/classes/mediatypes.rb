class ZabbixApi
  class Mediatypes < Basic

    def array_flag
      true
    end

    def method_name
      "mediatype"
    end

    def indentify
      "description"
    end

    def default_options 
      {
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

  end
end
