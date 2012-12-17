require "zabbixapi/version"
require "zabbixapi/client"
require "zabbixapi/basic"
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
  attr :mediatypes

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

    @server = Server.new(@client)
    @users   = Users.new(@client)
    @items   = Items.new(@client)
    @hosts   = Hosts.new(@client)
    @applications = Applications.new(@client)
    @templates    = Templates.new(@client)
    @hostgroups   = HostGroups.new(@client)
    @triggers = Triggers.new(@client)
    @graphs = Graphs.new(@client)
    @screens = Screens.new(@client)
    @usergroups = Usergroups.new(@client)
    @mediatypes = Mediatypes.new(@client)
  end

end
