module Zabbix
	class ZabbixApi
		def add_item(item)
				
			item_options = {
                    'description'           => nil,
	            'key_'                  => nil,
                    'hostid'                => nil,
                    'delay'                 => 60,
                    'history'               => 60,
                    'status'                => 0,
                    'type'                  => 7,
                    'snmp_community'        => '',
                    'snmp_oid'              => '',
                    'value_type'            => 3,
                    'data_type'             => 0,
                    'trapper_hosts'         => 'localhost',
                    'snmp_port'             => 161,
                    'units'                 => '',
                    'multiplier'            => 0,
                    'delta'                 => 0,
                    'snmpv3_securityname'   => '',
                    'snmpv3_securitylevel'  => 0,
                    'snmpv3_authpassphrase' => '',
                    'snmpv3_privpassphrase' => '',
                    'formula'               => 0,
                    'trends'                => 365,
                    'logtimefmt'            => '',
                    'valuemapid'            => 0,
                    'delay_flex'            => '',
                    'authtype'              => 0,
                    'username'              => '',
                    'password'              => '',
                    'publickey'             => '',
                    'privatekey'            => '',
                    'params'                => '',
                    'ipmi_sensor'           => '',
                    'applications'          => '',
                    'templateid'            => 0
				}


				item_options.merge!(item)
		
				message = {
					'method' => 'item.create',
					'params' => [ item_options ]
				}


				responce = send_request(message)

				unless ( responce.empty? ) then
					result = responce['itemids'][0]
				else
					result = nil
				end

				return result
		end


		def get_webitem_id(host_id, item_name)
			message = {
				'method' => 'item.get',
				'params' => {
					'filter' => {
						'hostid' => host_id,
						'type' => 9,
						'key_' => "web.test.time[eva.ru,Get main page,resp]"
					},
					'webitems' => 1
				}
			}

			responce = send_request(message)
		
			p responce
	
			unless ( responce.empty? ) then
				result = responce[0]['itemid']
			else
				result = nil
			end

			return result

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

			responce = send_request(message)
			
			unless ( responce.empty? ) then
				result = responce[0]['itemid']
			else
				result = nil
			end

			return result

		end

		def update_item(item_id)

			message = {
				'method' => 'item.update',
				'params' => {
						'itemid' => item_id,
						'status' => 0 
				}
			}

			responce = send_request(message)

			p responce
		end
	end
end
