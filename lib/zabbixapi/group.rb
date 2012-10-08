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
      response = send_request(message)
      response.empty? ? nil : response[0]['groupid']
    end

    def group_exist?(pattern)
      group_id = get_group_id(pattern)
      group_id ? true : false
    end

    def add_group(groupname)
      message = {
          'method' => 'hostgroup.create',
          'params' => {
              'name' => groupname
          }
      }
      response = send_request(message)
      response ? response['groupids'][0].to_i : nil
    end

    def delete_group(groupname)
      group_id = get_group_id(groupname)
      message = {
          'method' => 'hostgroup.delete',
          'params' => {
              'groupid' => group_id
          }
      }
      response = send_request(message)
      response ? true : false
    end

    def add_host_to_group(host_id, group_id)
      message = {
          'method' => 'hostgroup.massAdd',
          'params' => {
              'groups' => [group_id],
              'hosts' => [host_id]
          }
      }
      response = send_request(message)
      response ? true : false
    end

  end
end
