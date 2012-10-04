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

      if not ( response.empty? ) then
        result = response['templateids'][0].to_i
      else
        result = nil
      end

      return result
    end

    def get_template_ids_by_host(host_id)

      message = {
        'method' => 'template.get',
        'params' => {
          'hostids' => [ host_id ]
        }
      }

      response = send_request(message)

      unless ( response.empty? ) then
        result = []
        response.each_key() do |template_id|
          result << template_id
        end
      else
        result = nil
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

      unless response.empty? then
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
      else
        result = nil
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

      unless response.empty? then
        result = response.keys[0]
      else
        result = nil
      end

      return result

    end

    def link_templates_with_hosts(templates_id, hosts_id)

      if templates_id.class == Array then
        message_templates_id = templates_id
      else
        message_templates_id = [ templates_id ]
      end

      if hosts_id == Array then
        message_hosts_id = hosts_id
      else
        message_hosts_id = [ hosts_id ]
      end

      message = {
        'method' => 'template.massAdd',
        'params' => {
          'hosts' => message_hosts_id.map{|t| {"hostid" => t}},
          'templates' => message_templates_id.map{|t| {"templateid" => t}}
        }
      }

      response = send_request(message)

      return response
    end

    def unlink_templates_from_hosts(templates_id, hosts_id)

      if templates_id.class == Array then
        message_templates_id = templates_id
      else
        message_templates_id = [ templates_id ]
      end

      if hosts_id == Array then
        message_hosts_id = hosts_id
      else
        message_hosts_id = [ hosts_id ]
      end

      message = {
        'method' => 'template.massRemove',
        'params' => {
          'hostids' => message_hosts_id,
          'templateids' => message_templates_id,
          'force' => '1'
        }
      }

      response = send_request(message)

      return response
    end
  end
end
