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
trigger = "trigger____1"
user = "user____1"
user2 = "user____2"
usergroup = "SomeUserGroup"
graph = "graph___a"
mediatype = "somemediatype"


puts "### Zabbix API server version #{zbx.server.version} ###"

describe ZabbixApi, "test_api" do

  it "SERVER: Get version api" do
    zbx.server.version.should be_kind_of(String)
  end

  it "HOSTGROUP: Create" do
    $hostgroup_id_real = zbx.hostgroups.create(:name => hostgroup)
    $hostgroup_id_real.should be_kind_of(Integer)
  end

  it "HOSTGROUP: Find" do
    zbx.hostgroups.get_id(:name => hostgroup).should equal $hostgroup_id_real
  end

  it "HOSTGROUP: Find unknown" do
    zbx.hostgroups.get_id(:name => "#{hostgroup}______").should be_kind_of(NilClass)
  end

  it "HOSTGROUP: Create or get" do
    zbx.hostgroups.get_or_create(:name => hostgroup).should equal $hostgroup_id_real
  end

  it "HOSTGROUP: Get all" do
    zbx.hostgroups.all.should include(hostgroup => $hostgroup_id_real.to_s)
  end

  it "TEMPLATE: Create" do
    $template_id_real = zbx.templates.create(
      :host => template,
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    )
    $template_id_real.should be_kind_of(Integer)
  end

  it "TEMPLATE: Get get or create" do
    zbx.templates.get_or_create(
      :host => template,
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    ).should equal $template_id_real
  end

  it "TEMPLATE: Find" do
    zbx.templates.get_id(:host => template).should equal $template_id_real
  end

  it "TEMPLATE: Find unknown" do
    zbx.templates.get_id(:host => "#{template}_____").should be_kind_of(NilClass)
  end

  it "TEMPLATE: Get all" do
    zbx.templates.all.should include(template => $template_id_real.to_s)
  end

  it "APPLICATION: Create" do
    $application_id_real = zbx.applications.create(
      :name => application,
      :hostid => zbx.templates.get_id(:host => template)
    )
    $application_id_real.should be_kind_of(Integer)
  end

  it "APPLICATION: Get all" do
    zbx.applications.all.should include(application => $application_id_real.to_s)
  end

  it "APPLICATION: Get or create" do
    zbx.applications.get_or_create(
      :name => application,
      :hostid => zbx.templates.get_id(:host => template)
    ).should equal $application_id_real
  end

  it "APPLICATION: Find" do
    zbx.applications.get_id(:name => application).should equal $application_id_real
  end

  it "APPLICATION: Find unknown" do
    zbx.applications.get_id(:name => "#{application}___").should be_kind_of(NilClass)
  end

  it "ITEM: Create" do
    $item_id_real = zbx.items.create(
      :description => item,
      :key_ => "proc.num[aaa]",
      :hostid => zbx.templates.get_id(:host => template),
      :applications => [zbx.applications.get_id(:name => application)]
    )
    $item_id_real.should be_kind_of(Integer)
  end

  it "ITEM: Find" do
    zbx.items.get_id(:description => item).should equal $item_id_real
  end

  it "ITEM: Get all" do
    zbx.items.all.should include(item => $item_id_real.to_s)
  end

  it "ITEM: Update" do
    zbx.items.update(
      :itemid => zbx.items.get_id(:description => item),
      :status => 0
    ).should equal $item_id_real
  end

  it "ITEM: Create or update" do
    zbx.items.create_or_update(
      :description => item,
      :key_ => "proc.num[aaa]",
      :type => 6,
      :hostid => zbx.templates.get_id(:host => template),
      :applications => [zbx.applications.get_id(:name => application)]
    ).should equal $item_id_real
  end

  it "ITEM: Get unknown" do
    zbx.items.get_id(:description => "#{item}_____").should be_kind_of(NilClass)
  end

  it "HOST: Create" do
    $host_id_real = zbx.hosts.create(
      :host => host,
      :ip => "10.20.48.88",
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    )
    $host_id_real.should be_kind_of(Integer)
  end

  it "HOST: Update or create" do
    zbx.hosts.create_or_update(
      :host => host,
      :ip => "10.20.48.89",
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    ).should equal $host_id_real
  end

  it "HOST: Find unknown" do
    zbx.hosts.get_id(:host => "#{host}___").should be_kind_of(NilClass)
  end

  it "HOST: Find" do
    zbx.hosts.get_id(:host => host).should equal $host_id_real
  end

  it "HOST: Update" do
    zbx.hosts.update(
      :hostid => zbx.hosts.get_id(:host => host),
      :status => 0
    ).should equal $host_id_real
  end

  it "HOST: Get all" do
    zbx.hosts.all.should include(host => $host_id_real.to_s)
  end

  it "TEMPLATE: Linked hosts with templates" do
    zbx.templates.mass_add(
      :hosts_id => [zbx.hosts.get_id(:host => host)],
      :templates_id => [zbx.templates.get_id(:host => template)]
    ).should be_kind_of(TrueClass)
  end

  it "TEMPLATE: Update hosts with templates" do
    zbx.templates.mass_update(
      :hosts_id => [zbx.hosts.get_id(:host => host)],
      :templates_id => [zbx.templates.get_id(:host => template)]
    ).should be_kind_of(TrueClass)
  end

  it "TEMPLATE: Get all templates linked with host" do
    zbx.templates.get_ids_by_host(
      :hostids => [zbx.hosts.get_id(:host => host)]
    ).should include($template_id_real.to_s)
  end

  it "TEMPLATE: Get all" do 
    zbx.templates.all.should include(template => $template_id_real.to_s)
  end

  it "TRIGGER: Create" do
    $trigger_id_real = zbx.triggers.create(
      :description => trigger,
      :expression => "{#{template}:proc.num[aaa].last(0)}<1",
      :comments => "Bla-bla is faulty (disaster)",
      :priority => 5,
      :status     => 0,
      :templateid => 0,
      :type => 0
    )
    $trigger_id_real.should be_kind_of(Integer)
  end

  it "TRIGGER: Find" do
    zbx.triggers.get_id(:description => trigger).should be_kind_of(Integer)
  end

  it "TRIGGER: Find unknown" do
    zbx.triggers.get_id(:description => "#{trigger}____").should be_kind_of(NilClass)
  end

  it "TRIGGER: Get all" do
    zbx.triggers.all.should be_kind_of(Hash)
  end

  it "GRAPH: Create" do 
    gitems = {
        :itemid => zbx.items.get_id(:description => item), 
        :calc_fnc => "2",
        :type => "0",
        :periods_cnt => "5"
    }
    $graph_id_real = zbx.graphs.create(
      :gitems => [gitems],
      :show_triggers => "0",
      :name => graph,
      :width => "900",
      :height => "200"
    )
    $graph_id_real.should be_kind_of(Integer)
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
    ).should equal $graph_id_real
  end

  it "GRAPH: Find gititems" do
    zbx.graphs.get_items( zbx.graphs.get_id(:name => graph) ).should be_kind_of(Array)
  end

  it "GRAPH: Find" do
    zbx.graphs.get_id( :name => graph ).should equal $graph_id_real
  end

  it "GRAPH: get_ids_by_host" do
    zbx.graphs.get_ids_by_host( :host => host ).should be_kind_of(Array)
  end

  it "GRAPH: Get all" do
    zbx.graphs.all.should include(graph => $graph_id_real.to_s)
  end

  it "GRAPH: Update" do
    zbx.graphs.update(
      :graphid => zbx.graphs.get_id(
        :name => graph,
        :hostid => zbx.hosts.get_id(:host => host)
      ), 
      :ymax_type => 1
    ).should equal $graph_id_real
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
  ).should equal $graph_id_real
  end

  it "SCREEN: Get or create for host" do
    $screen_id_real = zbx.screens.get_or_create_for_host(
      :host => host,
      :graphids => zbx.graphs.get_ids_by_host(:host => host)
    )
    $screen_id_real.should be_kind_of(Integer)
  end

  it "TEMPLATE: Unlink hosts from templates" do
    zbx.templates.mass_remove(
      :hosts_id => [zbx.hosts.get_id(:host => host)],
      :templates_id => [zbx.templates.get_id(:host => template)]
    ).should be_kind_of(TrueClass)
  end

  it "SCREEN: Get all" do
    zbx.screens.all.should be_kind_of(Hash)
  end

  it "SCREEN: Delete" do
    zbx.screens.delete(
      [zbx.screens.get_id(:name => "#{host}_graphs")]
    ).should equal $screen_id_real
  end

  it "GRAPH: Delete" do
    zbx.graphs.delete(zbx.graphs.get_id(:name => graph)).should be_kind_of(Integer)
  end

  it "TRIGGER: Delete" do
    zbx.triggers.delete( zbx.triggers.get_id(:description => trigger) ).should be_kind_of(Integer)
  end

  it "HOST: Delete" do
    zbx.hosts.delete( zbx.hosts.get_id(:host => host) ).should equal $host_id_real
  end

  it "ITEM: Delete" do
    zbx.items.delete(
      zbx.items.get_id(:description => item)
    ).should equal $item_id_real
  end

  it "APPLICATION: Delete" do
    zbx.applications.delete( zbx.applications.get_id(:name => application) ).should equal $application_id_real
  end

  it "TEMPLATE: Delete" do
    zbx.templates.delete(zbx.templates.get_id(:host => template)).should equal $template_id_real
  end

  it "HOSTGROUP: Delete" do
    zbx.hostgroups.delete(
      zbx.hostgroups.get_id(:name => hostgroup)
    ).should equal $hostgroup_id_real
  end

  it "USER: Create" do
    $user_id_real = zbx.users.create(
      :alias => "Test #{user}",
      :name => user,
      :surname => user,
      :passwd => user
    )
    $user_id_real.should be_kind_of(Integer)
  end

  it "USER: Create or update" do
    zbx.users.create_or_update(
      :alias => "Test #{user}",
      :name => user,
      :surname => user,
      :passwd => user
    ).should equal $user_id_real
  end

  it "USER: Update" do
    zbx.users.update(:userid => zbx.users.get_id(:name => user), :name => user2).should equal $user_id_real
  end

  it "USER: Find unknown" do
    zbx.users.get_id(:name => "#{user}_____").should be_kind_of(NilClass)
  end

  it "USERGROUPS: Create" do
    $usergrp_id_real = zbx.usergroups.create(:name => usergroup)
    $usergrp_id_real.should be_kind_of(Integer)
  end

  it "USERGROUPS: Create or update" do
    zbx.usergroups.get_or_create(:name => usergroup).should equal $usergrp_id_real
  end

  it "USERGROUPS: Add user" do
    zbx.usergroups.add_user(
        :usrgrpids => [zbx.usergroups.get_id(:name => usergroup)],
        :userids => [zbx.users.get_id(:name => user2)]
    ).should equal $usergrp_id_real
  end

  it "USERGROUPS: Set UserGroup read & write perm" do
    zbx.usergroups.set_perms(
      :usrgrpid => zbx.usergroups.get_or_create(:name => usergroup).to_s,
      :hostgroupids => zbx.hostgroups.all.values,
      :permission => 3
    ).should equal $usergrp_id_real
  end

  it "MEDIATYPE: Create" do
    $meditype_id_real = zbx.mediatypes.create(
      :description => mediatype,
      :type => 0,
      :smtp_server => "127.0.0.1",
      :smtp_email => "zabbix@test.com"
    )
    $meditype_id_real.should be_kind_of(Integer)
  end

  it "MEDIATYPE: Update or create" do
    zbx.mediatypes.create_or_update(
      :description => mediatype,
      :smtp_email => "zabbix2@test.com"
    ).should equal $meditype_id_real
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
    ).should equal $user_id_real
  end

  it "MEDIATYPE: Delete" do
    zbx.mediatypes.delete(
      zbx.mediatypes.get_id(:description => mediatype)
    ).should equal $meditype_id_real
  end

  it "USER: Delete" do
    zbx.users.delete(zbx.users.get_id(:name => user2)).should equal $user_id_real
  end

  it "USERGROUPS: Delete" do
    zbx.usergroups.delete([zbx.usergroups.get_id(:name => usergroup)]).should equal $usergrp_id_real
  end

  it "QUERY" do
    zbx.query(
      :method => "apiinfo.version", 
      :params => {}
    ).should be_kind_of(String)
  end

end
