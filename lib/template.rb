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

      responce = send_request(message)

      if not ( responce.empty? ) then
        result = responce['templateids'][0].to_i
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

      responce = send_request(message)

      unless ( responce.empty? ) then
        result = []
        responce.each_key() do |template_id|
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

      responce = send_request(message)


      unless ( responce.empty? ) then

        template_ids = responce.keys()

        result = {}

        template_ids.each() do |template_id|
          template_name = responce[template_id]['host']
          result[template_id] = template_name
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

      responce = send_request(message)

      if not ( responce.empty? ) then
        result = responce.keys[0]
      else
        result = nil
      end

      return result

    end

    def link_templates_with_hosts(templates_id, hosts_id)

      if ( templates_id.class == Array ) then
        message_templates_id = templates_id
      else
        message_templates_id = [ templates_id ]
      end

      if ( hosts_id == Array ) then
        message_hosts_id = hosts_id
      else
        message_hosts_id = [ hosts_id ]
      end

      message = {
        'method' => 'template.massAdd',
        'params' => {
          'hosts' => message_hosts_id,
          'templates' => message_templates_id
        }
      }

      responce = send_request(message)

      return responce
    end

    def unlink_templates_from_hosts(templates_id, hosts_id)

      if ( templates_id.class == Array ) then
        message_templates_id = templates_id
      else
        message_templates_id = [ templates_id ]
      end

      if ( hosts_id == Array ) then
        message_hosts_id = hosts_id
      else
        message_hosts_id = [ hosts_id ]
      end

      message = {
        'method' => 'template.massRemove',
        'params' => {
          'hosts' => message_hosts_id,
          'templates' => message_templates_id,
          'force' => '1'
        }
      }

      responce = send_request(message)

      return responce
    end
  end
end
