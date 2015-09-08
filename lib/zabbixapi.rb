require "zabbixapi/version"
require "zabbixapi/client"

require "zabbixapi/basic/basic_alias"
require "zabbixapi/basic/basic_func"
require "zabbixapi/basic/basic_init"
require "zabbixapi/basic/basic_logic"

require "zabbixapi/classes/applications"
require "zabbixapi/classes/errors"
require "zabbixapi/classes/graphs"
require "zabbixapi/classes/hostgroups"
require "zabbixapi/classes/hosts"
require "zabbixapi/classes/items"
require "zabbixapi/classes/mediatypes"
require "zabbixapi/classes/proxies"
require "zabbixapi/classes/screens"
require "zabbixapi/classes/server"
require "zabbixapi/classes/templates"
require "zabbixapi/classes/triggers"
require "zabbixapi/classes/unusable"
require "zabbixapi/classes/usergroups"
require "zabbixapi/classes/usermacros"
require "zabbixapi/classes/users"
require "zabbixapi/classes/configurations"

class ZabbixApi

  attr :client

  def self.connect(options = {})
    new(options)
  end

  def self.current
    @current ||= ZabbixApi.new
  end

  def query(data)
    @client.api_request(:method => data[:method], :params => data[:params])
  end

  def initialize(options = {})
    @client = Client.new(options)
  end

  def server
    @server ||= Server.new(@client)
  end

  def users
    @users ||= Users.new(@client)
  end

  def items
    @items ||= Items.new(@client)
  end

  def hosts
    @hosts ||= Hosts.new(@client)
  end

  def applications
    @applications ||= Applications.new(@client)
  end

  def templates
    @templates ||= Templates.new(@client)
  end

  def hostgroups
    @hostgroups ||= HostGroups.new(@client)
  end

  def triggers
    @triggers ||= Triggers.new(@client)
  end

  def graphs
    @graphs ||= Graphs.new(@client)
  end

  def proxies
    @proxies ||= Proxies.new(@client)
  end

  def screens
    @screens ||= Screens.new(@client)
  end

  def usergroups
    @usergroups ||= Usergroups.new(@client)
  end

  def usermacros
    @usermacros ||= Usermacros.new(@client)
  end

  def mediatypes
    @mediatypes ||= Mediatypes.new(@client)
  end

  def configurations
    @configurations ||= Configurations.new(@client)
  end

end
