#encoding: utf-8

require 'spec_helper'

describe 'host' do
  before :all do
    @hostgroup = gen_name 'hostgroup'
    @hostgroupid = zbx.hostgroups.create(:name => @hostgroup)
  end

  context 'when name not exists' do
    before do
      @host = gen_name 'host'
    end

    describe 'create' do
      it "should return integer id" do
        hostid = zbx.hosts.create(
          :host => @host,
          :interfaces => [
            {
              :type => 1,
              :main => 1,
              :ip => "10.20.48.88",
              :dns => "",
              :port => 10050,
              :useip => 1
            }
          ],
          :groups => [:groupid => @hostgroupid]
        )
        hostid.should be_kind_of(Integer)
      end
    end

    describe 'get_id' do
      it "should return nil" do
        expect(zbx.hosts.get_id(:host => @host)).to be_kind_of(NilClass)
      end
    end
  end

  context 'when name exists' do
    before :all do
      @host = gen_name 'host'
      @hostid = zbx.hosts.create(
        :host => @host,
        :interfaces => [
          {
            :type => 1,
            :main => 1,
            :ip => "10.20.48.88",
            :dns => "",
            :port => 10050,
            :useip => 1
          }
        ],
        :groups => [:groupid => @hostgroupid]
      )
    end

    describe 'get_or_create' do
      it "should return id of host" do
        expect(zbx.hosts.get_or_create(
          :host => @host,
          :groups => [:groupid => @hostgroupid]
        )).to eq @hostid
      end
    end

    describe 'get_full_data' do
      it "should contains created host" do
        expect(zbx.hosts.get_full_data(:host => @host)[0]).to include("host" => @host)
      end
    end

    describe 'get_id' do
      it "should return id of host" do
        expect(zbx.hosts.get_id(:host => @host)).to eq @hostid
      end
    end

    describe 'create_or_update' do
      it "should return id of updated host" do
        zbx.hosts.create_or_update(
          :host => @host,
          :interfaces => [
            {
              :type => 1,
              :main => 1,
              :ip => "10.20.48.89",
              :port => 10050,
              :useip => 1,
              :dns => ''
            }
          ],
          :groups => [:groupid => @hostgroupid]
        ).should eq @hostid
      end
    end

    describe 'update' do
      it "should return id" do
        zbx.hosts.update(
          :hostid => @hostid,
          :status => 0
        ).should eq @hostid
      end
    end
  end
end

