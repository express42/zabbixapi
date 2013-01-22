#encoding: utf-8
require 'rspec'
require 'zabbixapi'

# settings
api_url = 'http://zabbix/api_jsonrpc.php'
#api_url = 'http://zabbix/zabbix20/api_jsonrpc.php'

api_login = 'Admin'
api_password = 'zabbix'

zbx = ZabbixApi.connect(
  :url => api_url,
  :user => api_login,
  :password => api_password,
  :debug => false
)

hostgroup = "hostgroup______1"
template  = "template______1"
application = "application_____1"
item = "item_____1"
host = "hostname____1"
trigger = "trigger____1" #TODO !saDSASDAS
user = "user____1"
user2 = "user____2"
usergroup = "SomeUserGroup"
graph = "graph___a"
mediatype = "somemediatype"

hostgroupid = 0
templateid = 0
applicationid = 0
itemid = 0
hostid = 0
triggerid = 0
userid = 0
usergroupid = 0
graphid = 0
screenid = 0
mediatypeid = 0


puts "### Zabbix API server version #{zbx.server.version} ###"

describe ZabbixApi do

  it "SERVER: Get version api" do
    zbx.server.version.should be_kind_of(String)
  end

  it "HOSTGROUP: Create" do
    hostgroupid = zbx.hostgroups.create(:name => hostgroup)
    hostgroupid.should be_kind_of(Integer)
  end

  it "HOSTGROUP: Find" do
    zbx.hostgroups.get_id(:name => hostgroup).should eq hostgroupid
  end

  it "HOSTGROUP: Find unknown" do
    zbx.hostgroups.get_id(:name => "#{hostgroup}______").should be_kind_of(NilClass)
  end

  it "HOSTGROUP: Create or get" do
    zbx.hostgroups.get_or_create(:name => hostgroup).should eq hostgroupid
  end

  it "HOSTGROUP: Create or update" do
    zbx.hostgroups.create_or_update(:name => hostgroup).should eq hostgroupid
  end

  it "HOSTGROUP: Get all" do
    zbx.hostgroups.all.should include(hostgroup=>hostgroupid.to_s)
  end

  it "TEMPLATE: Create" do
    templateid = zbx.templates.create(
      :host => template,
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    )
    templateid.should be_kind_of(Integer)
  end

  it "TEMPLATE: Get get or create" do
    zbx.templates.get_or_create(
      :host => template,
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    ).should eq templateid
  end

  it "TEMPLATE: Check full data" do
    zbx.templates.get_full_data(:host => template)[0].should include("host"=>template)
  end

  it "TEMPLATE: Find" do
    zbx.templates.get_id(:host => template).should eq templateid
  end

  it "TEMPLATE: Find unknown" do
    zbx.templates.get_id(:host => "#{template}_____").should be_kind_of(NilClass)
  end

  it "APPLICATION: Create" do
    applicationid = zbx.applications.create(
      :name => application,
      :hostid => zbx.templates.get_id(:host => template)
    )
    applicationid.should be_kind_of(Integer)
  end

  it "APPLICATION: Get or create" do
    zbx.applications.get_or_create(
      :name => application,
      :hostid => zbx.templates.get_id(:host => template)
    ).should eq applicationid
  end

  it "APPLICATION: Full info check" do
    zbx.applications.get_full_data(:name => application)[0].should include("name"=>application)
  end

  it "APPLICATION: Find" do
    zbx.applications.get_id(:name => application).should eq applicationid
  end

  it "APPLICATION: Find unknown" do
    zbx.applications.get_id(:name => "#{application}___").should be_kind_of(NilClass)
  end

  it "ITEM: Create" do
    itemid = zbx.items.create(
      :description => item,
      :key_ => "proc.num[aaa]",
      :hostid => zbx.templates.get_id(:host => template),
      :applications => [zbx.applications.get_id(:name => application)]
    )
    itemid.should be_kind_of(Integer)
  end

  it "ITEM: Full info check" do
    zbx.items.get_full_data(:description => item)[0].should include("description"=>item)
  end

  it "ITEM: Find" do
    zbx.items.get_id(:description => item).should eq itemid
  end

  it "ITEM: Update" do
    zbx.items.update(
      :itemid => zbx.items.get_id(:description => item),
      :status => 1
    ).should eq itemid
  end

  it "ITEM: Create or update (update)" do
    zbx.items.create_or_update(
      :description => item,
      :key_ => "proc.num[aaa]",
      :status => 0,
      :hostid => zbx.templates.get_id(:host => template),
      :applications => [zbx.applications.get_id(:name => application)]
    ).should eq itemid
  end

  it "ITEM: Create or update (create)" do
    zbx.items.create_or_update(
      :description => item + "____1",
      :key_ => "proc.num[aaabb]",
      :status => 0,
      :hostid => zbx.templates.get_id(:host => template),
      :applications => [zbx.applications.get_id(:name => application)]
    ).should eq itemid + 1
  end

  it "ITEM: Get unknown" do
    zbx.items.get_id(:description => "#{item}_____").should be_kind_of(NilClass)
  end

  it "HOST: Create" do
    hostid = zbx.hosts.create(
      :host => host,
      :ip => "10.20.48.88",
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    )
    hostid.should be_kind_of(Integer)
  end

  it "HOST: Update or create (update)" do
    zbx.hosts.create_or_update(
      :host => host,
      :ip => "10.20.48.89",
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    ).should eq hostid
  end

  it "HOST: Find unknown" do
    zbx.hosts.get_id(:host => "#{host}___").should be_kind_of(NilClass)
  end

  it "HOST: Find" do
    zbx.hosts.get_id(:host => host).should eq hostid
  end

  it "HOST: Update" do
    zbx.hosts.update(
      :hostid => zbx.hosts.get_id(:host => host),
      :status => 0
    ).should eq hostid
  end

  it "TEMPLATE: Update hosts with templates" do
    zbx.templates.mass_update(
      :hosts_id => [zbx.hosts.get_id(:host => host)],
      :templates_id => [zbx.templates.get_id(:host => template)]
    ).should be_kind_of(TrueClass)
  end

  it "TEMPLATE: Get all templates linked with host" do
    tmpl_array = zbx.templates.get_ids_by_host(
      :hostids => [zbx.hosts.get_id(:host => host)]
    )
    tmpl_array.should be_kind_of(Array)
    tmpl_array.should include templateid.to_s
  end

  it "TEMPLATE: Linked hosts with templates" do
    zbx.templates.mass_add(
      :hosts_id => [zbx.hosts.get_id(:host => host)],
      :templates_id => [zbx.templates.get_id(:host => template)]
    ).should be_kind_of(TrueClass)
  end

  it "TEMPLATE: Get all" do 
    zbx.templates.all.should include(template=>templateid.to_s)
  end

  it "TRIGGER: Create" do
    triggerid = zbx.triggers.create(
      :description => trigger,
      :expression => "{#{template}:proc.num[aaa].last(0)}<1",
      :comments => "Bla-bla is faulty (disaster)",
      :priority => 5,
      :status     => 0,
      :templateid => 0,
      :type => 0
    )
    triggerid.should be_kind_of(Integer)
  end

  it "TRIGGER: Create or update (not realy update)" do
    zbx.triggers.create_or_update(
      :description => trigger,
      :expression => "{#{template}:proc.num[aaa].last(0)}<1",
      :comments => "Bla-bla is faulty (disaster)",
      :priority => 5,
      :status     => 0,
      :templateid => 0,
      :type => 0
    ).should eq triggerid + 1
  end


  it "TRIGGER: Create or update (realy update)" do
    zbx.triggers.create_or_update(
      :description => trigger,
      :expression => "{#{template}:proc.num[aaa].last(2)}<1",
      :comments => "Bla-bla (2) is faulty (disaster)",
      :priority => 5,
      :status     => 0,
      :templateid => 0,
      :type => 0
    ).should eq triggerid + 1
  end

  it "TRIGGER: Find" do
    zbx.triggers.get_id(:description => trigger).should eq triggerid + 1 # вау блять
  end

  it "GRAPH: Create" do 
    gitems = {
        :itemid => zbx.items.get_id(:description => item), 
        :calc_fnc => "2",
        :type => "0",
        :periods_cnt => "5"
    }
    graphid = zbx.graphs.create(
      :gitems => [gitems],
      :show_triggers => "0",
      :name => graph,
      :width => "900",
      :height => "200"
    )
    graphid.should be_kind_of(Integer)
  end

  it "GRAPH: Create or get" do 
    gitems = {
        :itemid => zbx.items.get_id(:description => item), 
        :calc_fnc => "2",
        :type => "0",
        :periods_cnt => "5"
    }
    zbx.graphs.get_or_create(
      :gitems => [gitems],
      :show_triggers => "0",
      :name => graph,
      :width => "900",
      :height => "200"
    ).should eq graphid
  end

  it "GRAPH: Find gititems" do
    zbx.graphs.get_items( zbx.graphs.get_id(:name => graph) )
  end

  it "GRAPH: Find" do
    zbx.graphs.get_id( :name => graph ).should eq graphid
  end

  it "GRAPH: get_ids_by_host" do
    graph_array = zbx.graphs.get_ids_by_host( :host => host )
    graph_array.should be_kind_of(Array)
    graph_array.should include(graphid.to_s)
  end

  it "GRAPH: Update" do
    zbx.graphs.update(
      :graphid => zbx.graphs.get_id(
        :name => graph,
        :hostid => zbx.hosts.get_id(:host => host)
      ), 
      :ymax_type => 1
    ).should eq graphid
  end

  it "GRAPH: Create or Update" do
    gitems = {
      :itemid => zbx.items.get_id(:description => item), 
      :calc_fnc => "3",
      :type => "0",
      :periods_cnt => "5"
    }
  zbx.graphs.create_or_update(
    :gitems => [gitems],
    :show_triggers => "1",
    :name => graph,
    :width => "900",
    :height => "200"
  ).should eq graphid
  end

  it "SCREEN: Get or create for host" do
    screenid = zbx.screens.get_or_create_for_host(
      :host => host,
      :graphids => zbx.graphs.get_ids_by_host(:host => host)
    )
    screenid.should be_kind_of(Integer)
  end

  it "TEMPLATE: Unlink hosts from templates" do
    zbx.templates.mass_remove(
      :hosts_id => [zbx.hosts.get_id(:host => host)],
      :templates_id => [zbx.templates.get_id(:host => template)]
    ).should be_kind_of(TrueClass)
  end

  it "SCREEN: Delete" do
    zbx.screens.delete(
      zbx.screens.get_id(:name => "#{host}_graphs")
    ).should eq screenid
  end

  it "GRAPH: Delete" do
    zbx.graphs.delete(zbx.graphs.get_id(:name => graph)).should be_kind_of(TrueClass)
  end

  it "TRIGGER: Delete" do
    zbx.triggers.delete( zbx.triggers.get_id(:description => trigger) ).should eq triggerid + 1 
  end

  it "HOST: Delete" do
    zbx.hosts.delete( zbx.hosts.get_id(:host => host) ).should eq hostid
  end

  it "ITEM: Delete" do
    zbx.items.delete(
      zbx.items.get_id(:description => item)
    ).should eq itemid
  end

  it "APPLICATION: Delete" do
    zbx.applications.delete( zbx.applications.get_id(:name => application) ).should eq applicationid
  end

  it "TEMPLATE: Delete" do
    zbx.templates.delete(zbx.templates.get_id(:host => template)).should eq templateid
  end

  it "HOSTGROUP: Delete" do
    zbx.hostgroups.delete(
      zbx.hostgroups.get_id(:name => hostgroup)
    ).should eq hostgroupid
  end

  it "USER: Create" do
    userid = zbx.users.create(
      :alias => "Test #{user}",
      :name => user,
      :surname => user,
      :passwd => user
    )
    userid.should be_kind_of(Integer)
  end

  it "USER: Create or update" do
    zbx.users.create_or_update(
      :alias => "Test #{user}",
      :name => user,
      :surname => user,
      :passwd => user
    ).should eq userid
  end

  it "USER: Find" do
    zbx.users.get_full_data(:name => user)[0]['name'].should be_kind_of(String)
  end

  it "USER: Update" do
    zbx.users.update(:userid => zbx.users.get_id(:name => user), :name => user2).should be_kind_of(Integer)
  end

  it "USER: Find unknown" do
    zbx.users.get_id(:name => "#{user}_____").should be_kind_of(NilClass)
  end

  it "USERGROUPS: Create" do
    usergroupid = zbx.usergroups.create(:name => usergroup)
    usergroupid.should be_kind_of(Integer)
  end

  it "USERGROUPS: Create or update" do
    zbx.usergroups.get_or_create(:name => usergroup).should eq usergroupid
  end

  it "USERGROUPS: Add user" do
    zbx.usergroups.add_user(
        :usrgrpids => [zbx.usergroups.get_id(:name => usergroup)],
        :userids => [zbx.users.get_id(:name => user2)]
    ).should eq usergroupid
  end

  it "USERGROUPS: Set UserGroup read & write perm" do
    zbx.usergroups.set_perms(
      :usrgrpid => zbx.usergroups.get_or_create(:name => usergroup).to_s,
      :hostgroupids => zbx.hostgroups.all.values,
      :permission => 3
    ).should eq usergroupid
  end

  it "MEDIATYPE: Create" do
    mediatypeid = zbx.mediatypes.create(
      :description => mediatype,
      :type => 0,
      :smtp_server => "127.0.0.1",
      :smtp_email => "zabbix@test.com"
    )
    mediatypeid.should be_kind_of(Integer)
  end

  it "MEDIATYPE: Update or create" do
    zbx.mediatypes.create_or_update(
      :description => mediatype,
      :smtp_email => "zabbix2@test.com"
    ).should eq mediatypeid
  end

  it "USER: Add mediatype" do
    zbx.users.add_medias(
      :userids => [zbx.users.get_id(:name => user2)],
      :media => [
        {
          :mediatypeid => zbx.mediatypes.get_id(:description => mediatype), 
          :sendto => "test@test", 
          :active => 0, 
          :period => "1-7,00:00-24:00",
          :severity => "56"
        }
      ]
    ).should eq userid
  end

  it "MEDIATYPE: Delete" do
    zbx.mediatypes.delete(
      zbx.mediatypes.get_id(:description => mediatype)
    ).should eq mediatypeid
  end

  it "USER: Delete" do
    zbx.users.delete(zbx.users.get_id(:name => user2)).should eq userid
  end

  it "USERGROUPS: Delete" do
    zbx.usergroups.delete([zbx.usergroups.get_id(:name => usergroup)]).should eq usergroupid
  end

  it "QUERY" do
    zbx.query(
      :method => "apiinfo.version", 
      :params => {}
    ).should be_kind_of(String)
  end

end
