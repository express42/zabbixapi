require "zabbixapi/basic"
require "zabbixapi/client"
require "zabbixapi/version"
require "zabbixapi/server"
require "zabbixapi/applications"
require "zabbixapi/templates"
require "zabbixapi/hostgroups"
require "zabbixapi/users"
require "zabbixapi/hosts"
require "zabbixapi/triggers"
require "zabbixapi/items"
require "zabbixapi/graphs"
require "zabbixapi/screens"
require "zabbixapi/usergroups"
require "zabbixapi/mediatypes"

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

  def screens
    @screens ||= Screens.new(@client)
  end

  def usergroups
    @usergroups ||= Usergroups.new(@client)
  end

  def mediatypes
    @mediatypes ||= Mediatypes.new(@client)
  end

end
