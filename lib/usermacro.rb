module Zabbix

	class ZabbixApi
		def add_macro(host_id, macro_name, macro_value)

			message = {
				'method' => 'Usermacro.create',
				'params' => {
					'hostid' => host_id,
					'macro' => macro_name,
					'value'=> macro_value
				}
			}

			responce = send_request(message)

			if ( hostmacroids = responce['hostmacroids'] ) then
				result = hostmacroids
			else
				result = nil
			end

			return result
		end

		def get_macro(host_id, macro_name)
		
			message = {
				'method' => 'Usermacro.get',
				'params' => {
					'hostids' => host_id,
					'macros' => macro_name,
					'extendoutput' => '1'
				}
			}

			responce = send_request(message)

			if not ( responce.empty?) then
				if ( hostmacroid =  responce[0]['hostmacroid'] ) then
					macro_id = hostmacroid
					macro_value = responce[0]['value']

					result = {
						'id' => macro_id,
						'value'=> macro_value
					}
				else
					result = nil
				end
			else
				result = nil
			end

			return result
		end

		def set_macro_value(host_id, macro_name, macro_value)
			
			message = {
				'method' => 'usermacro.updateValue',
				'params' => {
					'hostid' => host_id,
					'macro' => macro_name,
					'value' => macro_value
				}
			}

			responce = send_request(message)

			# Проверять ответ бесполезно. В ответ всегда возвращается запрос.
			return true
		end
	end
end
