#encoding: utf-8

require 'spec_helper'

describe 'usergroup' do

  context 'when not exists' do
    it "should be integer id" do
      usergroupid = zbx.usergroups.create(:name => gen_name('usergroup'))
      usergroupid.should be_kind_of(Integer)
    end
  end

  context 'when exists' do
    before do
      @usergroup = gen_name 'usergroup'
      @usergroupid = zbx.usergroups.create(:name => @usergroup)
      @user = gen_name 'user'
      @userid = zbx.users.create(
        :alias => @user,
        :name => @user,
        :surname => @user,
        :passwd => @user,
        :usrgrps => [@usergroupid]
      )

      @user2 = gen_name 'user'

      @userid2 = zbx.users.create(
        :alias => @user2,
        :name => @user2,
        :surname => @user2,
        :passwd => @user2,
        :usrgrps => [zbx.usergroups.create(:name => gen_name('usergroup'))]
      )
    end

    describe 'get_or_create' do
      it "should return id" do
        zbx.usergroups.get_or_create(:name => @usergroup).should eq @usergroupid
      end
    end

    describe 'add_user' do
      it "should return id" do
        zbx.usergroups.add_user(
            :usrgrpids => [@usergroupid],
            :userids => [@userid2]
        ).should eq @usergroupid
      end
    end

    describe 'set_perms' do
      it "should return id" do
        zbx.usergroups.set_perms(
          :usrgrpid => @usergroupid,
          :hostgroupids => zbx.hostgroups.all.values,
          :permission => 3
        ).should eq @usergroupid
      end
    end

    describe 'delete' do
      it "should raise error when has users with only one group" do
        expect { zbx.usergroups.delete(@usergroupid) }.to raise_error
      end

      it "should return id of deleted group" do
        usergroupid = zbx.usergroups.create(:name => gen_name('usergroup'))

        expect(zbx.usergroups.delete(usergroupid)).to eq usergroupid
      end
    end
  end
end
