class ZabbixApi
  class Mediatypes < Basic
    # The method name used for interacting with MediaTypes via Zabbix API
    #
    # @return [String]
    def method_name
      'mediatype'
    end

    # The id field name used for identifying specific MediaType objects via Zabbix API
    #
    # @return [String]
    def indentify
      'description'
    end

    # The default options used when creating MediaType objects via Zabbix API
    #
    # @return [Hash]
    def default_options
      {
        :description => '',  # Name
        :type        => 0,   # 0 - Email, 1 - External script, 2 - SMS, 3 - Jabber, 100 - EzTexting
        :smtp_server => '',
        :smtp_helo   => '',
        :smtp_email  => '',  # Email address of Zabbix server
        :exec_path   => '',  # Name of external script
        :gsm_modem   => '',  # Serial device name of GSM modem
        :username    => '',  # Jabber user name used by Zabbix server
        :passwd      => ''   # Jabber password used by Zabbix server
      }
    end
  end
end
