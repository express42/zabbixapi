#encoding: utf-8

require 'spec_helper'

describe 'server' do
  describe 'version' do
    it "should be string" do
      zbx.server.version.should be_kind_of(String)
    end

    it "should be 2.0.x" do
      zbx.server.version.should match(/2\.0\.\d+/)
    end
  end
end


