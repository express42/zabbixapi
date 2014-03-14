#encoding: utf-8

require 'spec_helper'

describe 'user' do
  it "USER: Create" do
    userid = zbx.users.create(
      :alias => "Test #{user}",
      :name => user,
      :surname => user,
      :passwd => user,
      :usrgrps => [usergroupid]
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

  it "USER: Delete" do
    zbx.users.delete(zbx.users.get_id(:name => user2)).should eq userid
  end
end
