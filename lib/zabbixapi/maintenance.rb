module Zabbix
  class ZabbixApi

    def create_maintenance(host_id, maintenance_options)
    	
    	time_now = Time.now.to_i 
    	
      maintenance_default = {
        'hostids'						=> [host_id],
        'groupids'					=> [],
		    'name'							=> '',
		    'maintenance_type'	=> '0', # 0 = with data collection, 1 = without
		    'description'				=> '',
		    'active_since'			=> '',
		    'active_till'				=> ''
      }
      message = {
        'method' => 'maintenance.create',
        'params' => merge_opt(maintenance_default, maintenance_options)
      }
      response = send_request(message)
      response.empty? ?  nil : response['maintenanceids'][0].to_i 
    end

    def get_maintenance_id(host_id)
      message = {
          'method' => 'maintenance.get',
          'params' => {
              'hostids' => [host_id]
          }
      }
      response = send_request(message)
      response.empty? ? nil : response[0]['maintenanceid'].to_i
    end
    
    def maintenance_exists?(maintenance_id)
    	# seems like .nodeids and .maintenance are ignored
    	# mmethner: .maintenanceid is the only settings which not always returns true
      message = {
        'method' => 'maintenance.exists',
        'params' => {
	        'nodeids'				=> [],
	        'maintenance'		=> '',
			    'maintenanceid'	=> maintenance_id,
	      }
      }
      response = send_request(message)
      response
    end

    def update_maintenance(maintenance_id, maintenance_options)
      
      maintenance_options["maintenanceid"] = maintenance_id
      message = {
        'method' => 'maintenance.update',
        'params' => maintenance_options
      }
      response = send_request(message)
      
      # the zabbix api returns boolean
      # even the official zabbix api documentation specifies an array
      response
    end
    
    def delete_maintenance(maintenance_id)
      message = {
        'method' => 'maintenance.delete',
        'params' => [maintenance_id]
      }
      response = send_request(message)
      
      # the zabbix api returns boolean
      # even the official zabbix api documentation specifies an array
      response
    end
    
  end
end
