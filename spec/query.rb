#encoding: utf-8

require 'spec_helper'

describe "query" do
  it "should works" do
    zbx.query(
      :method => "apiinfo.version",
      :params => {}
    ).should be_kind_of(String)
  end
end

