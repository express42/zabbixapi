require "zabbixapi/version"
require "zabbixapi/client"
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

class ZabbixApi

  attr :client
  attr :server
  attr :users
  attr :items
  attr :applications
  attr :templates
  attr :hostgroups
  attr :hosts
  attr :triggers
  attr :graphs
  attr :screens
  attr :usergroups

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
    @server = Server.new(options)
    @users   = Users.new(options)
    @items   = Items.new(options)
    @hosts   = Hosts.new(options)
    @applications = Applications.new(options)
    @templates    = Templates.new(options)
    @hostgroups   = HostGroups.new(options)
    @triggers = Triggers.new(options)
    @graphs = Graphs.new(options)
    @screens = Screens.new(options)
    @usergroups = Usergroups.new(options)
  end

end
