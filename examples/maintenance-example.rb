#
# gems
#
require 'zabbixapi'

#
# main
#
@yourZabbixHost = 'https://zabbix.example.com/api_jsonrpc.php'
@yourZabbixLogin = 'login'
@yourZabbixPassword = 'password'
@yourServerHost = 'examplehost'

# init
zbx = Zabbix::ZabbixApi.new(@yourZabbixHost, @yourZabbixLogin, @yourZabbixPassword)
zbx.debug = true

# find your host
host_id = zbx.get_host_id(@yourServerHost);
puts host_id

# create an 1hour maintenance period
# => true
time_now = Time.now.to_i
options = {
	'name'					=> 'maintenance example',
	'description'		=> 'maintenance example description ',
  'active_since'	=> time_now,
  'active_till'		=> time_now + 60*60
}
maintenance_id = zbx.create_maintenance(host_id,options)
puts maintenance_id

# is maintenance item available? 
# => true
puts zbx.maintenance_exists?(maintenance_id)

# update name, description and extend period to 3h 
# => true
options = {
	'name'					=> 'maintenance example update',
	'description'		=> 'maintenance example update description',
	'hostids'				=> [host_id],
  'active_since'	=> time_now,
  'active_till'		=> time_now + 180*60
}
puts zbx.update_maintenance(maintenance_id,options)

# delete it 
# => true
puts zbx.delete_maintenance(maintenance_id)

# is maintenance item still available? 
# => false
puts zbx.maintenance_exists?(maintenance_id)
