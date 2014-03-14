#encoding: utf-8

require 'spec_helper'

describe 'usergroup' do
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

  it "USERGROUPS: Delete" do
    zbx.usergroups.delete([zbx.usergroups.get_id(:name => usergroup)]).should eq usergroupid
  end

end
