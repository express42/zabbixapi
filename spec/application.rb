#encoding: utf-8

require 'spec_helper'

describe 'application' do
  before :all do
    @hostgroup = gen_name 'hostgroup'
    @hostgroupid = zbx.hostgroups.create(:name => @hostgroup)
    @template = gen_name 'template'
    @templateid = zbx.templates.create(
      :host => @template,
      :groups => [:groupid => @hostgroupid]
    )
  end

  context 'when name not exists' do
    before do
      @application = gen_name 'application'
    end

    describe 'create' do
      it "should return integer id" do
        applicationid = zbx.applications.create(
          :name => @application,
          :hostid => @templateid
        )
        applicationid.should be_kind_of(Integer)
      end
    end

    describe 'get_id' do
      it "should return nil" do
        expect(zbx.applications.get_id(:host => @application)).to be_kind_of(NilClass)
      end
    end
  end

  context 'when name exists' do
    before :all do
      @application = gen_name 'application'
      @applicationid = zbx.applications.create(
        :name => @application,
        :hostid => @templateid
      )
    end

    describe 'get_or_create' do
      it "should return id of application" do
        expect(zbx.applications.get_or_create(
          :name => @application,
          :hostid => @templateid
        )).to eq @applicationid
      end
    end

    describe 'get_full_data' do
      it "should contains created application" do
        matching_applications = zbx.applications.get_full_data(:name => @application).select { |a| a['name'] == @application }
        expect(matching_applications.count).to eq(1)
      end
    end

    describe 'get_id' do
      it "should return id of application" do
        expect(zbx.applications.get_id(:name => @application)).to eq @applicationid
      end
    end

    describe "delete" do
      it "should return id" do
        zbx.applications.delete(@applicationid).should eq @applicationid
      end
    end
  end
end
