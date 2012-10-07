module Zabbix
  class ZabbixApi
    def add_item(item)

      # Default item options
      # See: http://www.zabbix.com/documentation/1.8/api/item

      ## Item types (see ./frontends/php/include/defines.inc.php in zabbix source)
      # ITEM_TYPE_ZABBIX              0
      # ITEM_TYPE_SNMPV1              1
      # ITEM_TYPE_TRAPPER             2
      # ITEM_TYPE_SIMPLE              3
      # ITEM_TYPE_SNMPV2C             4
      # ITEM_TYPE_INTERNAL            5
      # ITEM_TYPE_SNMPV3              6
      # ITEM_TYPE_ZABBIX_ACTIVE       7
      # ITEM_TYPE_AGGREGATE           8
      # ITEM_TYPE_HTTPTEST            9
      # ITEM_TYPE_EXTERNAL            10
      # ITEM_TYPE_DB_MONITOR          11
      # ITEM_TYPE_IPMI                12
      # ITEM_TYPE_SSH                 13
      # ITEM_TYPE_TELNET              14
      # ITEM_TYPE_CALCULATED          15

      item_options = {
          'description' => nil,
          'key_' => nil,
          'hostid' => nil,
          'delay' => 60,
          'history' => 60,
          'status' => 0,
          'type' => 7,
          'snmp_community' => '',
          'snmp_oid' => '',
          'value_type' => 3,
          'data_type' => 0,
          'trapper_hosts' => 'localhost',
          'snmp_port' => 161,
          'units' => '',
          'multiplier' => 0,
          'delta' => 0,
          'snmpv3_securityname' => '',
          'snmpv3_securitylevel' => 0,
          'snmpv3_authpassphrase' => '',
          'snmpv3_privpassphrase' => '',
          'formula' => 0,
          'trends' => 365,
          'logtimefmt' => '',
          'valuemapid' => 0,
          'delay_flex' => '',
          'authtype' => 0,
          'username' => '',
          'password' => '',
          'publickey' => '',
          'privatekey' => '',
          'params' => '',
          'ipmi_sensor' => '',
          'applications' => '',
          'templateid' => 0
      }


      item_options.merge!(item)

      message = {
          'method' => 'item.create',
          'params' => [item_options]
      }

      response = send_request(message)

      response.empty? ? nil : response['itemids'][0]

    end

    def get_item_id(host_id, item_name)
      message = {
          'method' => 'item.get',
          'params' => {
              'filter' => {
                  'hostid' => host_id,
                  'description' => item_name
              }
          }
      }

      response = send_request(message)

      response.empty? ? nil : response[0]['itemid']

    end

    def item_exist?(host_id, item_name)
      item_id = get_item_id(host_id, item_name)
      if item_id
        result = true
      else
        result = false
      end

      return result
    end

    def update_item(item_id, options)

      options["item_id"]

      message = {
          'method' => 'item.update',
          'params' => options
      }

      response = send_request(message)

      response.empty? ?  nil : response['itemids'][0]

    end

    # Don't work with api < 1.8.4
    def delete_item(item_ids)

      if item_ids.kind_of? Array
        message = {
            'method' => 'item.delete',
            'params' => item_ids
        }
      elsif item_ids.kind_of? Fixnum or item_ids.kind_of? String
        message = {
            'method' => 'item.delete',
            'params' => [item_ids]
        }
      else
        raise Zabbix::ArgumentError.new("Zabbix::ZabbixApi.delete_item() argument error. item_ids => #{item_ids.inspect}")
      end

      response = send_request(message)

      if response.empty?
        result = nil
      else
        response['itemids'].count == 1 ? result = response['itemids'][0] : result = response['itemids']
      end

      return result
    end
  end
end
