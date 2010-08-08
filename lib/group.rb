module Zabbix

	class ZabbixApi
		def get_group_id(pattern)
			
			message = {
				'method' => 'hostgroup.get',
				'params' => {
					'filter' => {
						'name' => pattern
					}
				}
			}

			responce = send_request(message)

			if not ( responce.empty? ) then
				result = responce[0]['groupid']
			else
				result = nil
			end

			return result
		end

		def group_exist?(pattern)
		
			group_id = get_groups_id(pattern)

			if ( group_id ) then
				return true
			else
				return false
			end
		end

		def add_group(groupname)
			
			message = {
				'method' => 'hostgroup.create',
				'params' => {
					'name' => groupname 
				}
			}

			responce = send_request(message)

			if ( responce ) then
				result = responce['groupids'] 
			else
				result = nil
			end

			return result
		end

		def add_host_to_group(host_id, group_id)
			
			message = {
				'method' => 'hostgroup.massAdd',
				'params' => {
					'groups' => [ group_id ],
					'hosts' => [ host_id ]
				}
			}

			responce = send_request(message)

			if not ( responce.empty? ) then
				result = true
			else
				result = false
			end
			
			return result
		end
	end
end
