module Zabbix

  # Examples:
  # * Create host in zabbix
  #   
  #    zbx = Zabbix::ZabbixApi.new(url, user, password)
  #    host_options => {
  #      host => 'host.example.org',
  #      ip => '127.0.0.1',
  #      groups => [10001, 10002],
  #    }
  #    host_id = zbx.add_host(host_options)
  class ZabbixApi
    
    # Method for creation host in zabbix.
    # * Input parameter - hash <tt>host_options</tt>. Available keys in hash:
    #   - host - hostname. Type: string. Default: nil;
    #   - port - zabbix agent pont. Type: int. Default: 10050;
    #   - status - host status. Type: int. Possible values: 0 - monitored, 1 - not monitored. Default: 0; 
    #   - useip - use ip or dns name for monitoring host. Possible values: 0 - don't use ip (use dns name), 1 - use ip (don't use dns name);
    #   - ip - host's ip address. Used for monitoring host if useip set to 1. Default: '0.0.0.0';
    #   - proxy_hostid - host_id of zabbix proxy (if necessary). See <tt>get_host_id</tt>. Default: 0 (don't use proxy server);
    #   - groups - array of groups that belong host. Default: []. 
    #   - useipmi - Use or not ipmi. Default: 0 (don't use ipmi);
    #   - ipmi_ip - Default: '';
    #   - ipmi_port - Default: 623;
    #   - ipmi_authtype - Default: 0;
    #   - ipmi_privilege - Default: 0;
    #   - ipmi_username - Default: '';
    #   - ipmi_password - Default: '';
    def add_host(host_options)

      host_default = {
        'host' => nil,
        'port' => 10050,
        'status' => 0,
        'useip' => 0,
        'dns' => '',
        'ip' => '0.0.0.0',
        'proxy_hostid' => 0,
        'groups' => [],
        'useipmi' => 0,
        'ipmi_ip' => '',
        'ipmi_port' => 623,
        'ipmi_authtype' => 0,
        'ipmi_privilege' => 0,
        'ipmi_username' => '',
        'ipmi_password' => ''
      }

      host_options['groups'].map! { |group_id| {'groupid' => group_id} }

      host = merge_opt(host_default, host_options)

      message = {
        'method' => 'host.create',
        'params' => host
      }

      responce = send_request(message)

      if not ( responce.empty? ) then
        result = responce['hostids'][0].to_i
      else
        result = nil
      end

      return result
    end

    # Method for retrieving host id from zabbix by hostname.
    # * Non optional input parameters:
    #   - hostname - Type: String.
    # * Return:
    #   - host_id - Return finded host_id for passed hostname. If host not found in zabbix - return nil
    def get_host_id(hostname)
  
      message = {
        'method' => 'host.get',
        'params' => {
          'filter' => {
            'host' => hostname
          }
        }
      }

      responce = send_request(message)

      if not ( responce.empty? ) then
        result = responce[0]['hostid'].to_i
      else
        result = nil
      end

      return result
    end
  end
end
