module Zabbix
  class ZabbixApi

    def add_template(template_options)
      template_default = {
          'host' => nil,
          'groups' => [],
      }
      template_options['groups'].map! { |group_id| {'groupid' => group_id} }
      template = merge_opt(template_default, template_options)
      message = {
          'method' => 'template.create',
          'params' => template
      }
      response = send_request(message)
      response.empty? ? nil : response['templateids'][0].to_i
    end

    def add_or_get_template(template_options)
      unless t_id = get_template_id(template_options['host'])
        t_id = add_template(template_options)
      end
      return t_id
    end

    def get_template_ids_by_host(host_id)
      message = {
          'method' => 'template.get',
          'params' => {
              'hostids' => [host_id]
          }
      }
      response = send_request(message)
      if response.empty?
        result = nil
      else
        result = []
        response.each_key() do |template_id|
          result << template_id
        end
      end
      return result
    end

    def get_templates()
      message = {
          'method' => 'template.get',
          'params' => {
              'extendoutput' => '0'
          }
      }
      response = send_request(message)
      if response.empty?
        result = nil
      else
        result = {}
        if response.kind_of? Hash
          template_ids = response.keys()
          template_ids.each() do |template_id|
            template_name = response[template_id]['host']
            result[template_id] = template_name
          end
        elsif response.kind_of? Array
          response.each do |template_info|
            result[template_info['hostid']] = template_info['host']
          end
        end
      end
      return result
    end

    def get_template_id(template_name)
      message = {
          'method' => 'template.get',
          'params' => {
              'filter' => {
                  'host' => template_name
              }
          }
      }
      response = send_request(message)
      response.empty? ? nil : response[0]['templateid'].to_i
    end

    def link_templates_with_hosts(templates_id, hosts_id)
      templates_id.class == Array ? message_templates_id = templates_id : message_templates_id = [templates_id]
      hosts_id.class == Array ? message_hosts_id = hosts_id : message_hosts_id = [hosts_id]
      message = {
          'method' => 'template.massAdd',
          'params' => {
              'hosts' => message_hosts_id.map { |t| {"hostid" => t} },
              'templates' => message_templates_id.map { |t| {"templateid" => t} }
          }
      }
      response = send_request(message)
      response.empty? ? nil : response['templateid'][0].to_i
    end

    def unlink_templates_from_hosts(templates_id, hosts_id)
      templates_id.class == Array ? message_templates_id = templates_id : message_templates_id = [templates_id]
      hosts_id.class == Array ? message_hosts_id = hosts_id : message_hosts_id = [hosts_id]
      message = {
          'method' => 'template.massRemove',
          'params' => {
              'hostids' => message_hosts_id,
              'templateids' => message_templates_id,
              'force' => '1'
          }
      }
      response = send_request(message)
      response.empty? ? nil : response['templateids'][0].to_i
    end

    def delete_template(template_name)
      message = {
          'method' => 'template.delete',
          'params' => [
              {
                "templateid" => get_template_id(template_name)
              }
            ]
      }
      response = send_request(message)
      response.empty? ? nil : response['templateids'][0].to_i
    end

  end
end
