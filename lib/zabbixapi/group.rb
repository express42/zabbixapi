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

      response.empty? ? return nil : return response[0]['groupid']

    end

    def group_exist?(pattern)

      group_id = get_groups_id(pattern)

      group_id ? return true : return false
    end

    def add_group(groupname)

      message = {
          'method' => 'hostgroup.create',
          'params' => {
              'name' => groupname
          }
      }

      response = send_request(message)

      response ? return response['groupids'][0].to_i : return nil

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

      response.empty? ?  return false : return true

    end
  end
end
