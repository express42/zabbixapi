#encoding: utf-8

require 'spec_helper'

describe "query" do
  it "should works" do
    zbx.query(
      method: 'host.get',
      params: {
        filter: {
            host: 'asdf'
        },
        selectInterfaces: 'refer'
      }
    ).should be_kind_of(Array)
  end
end

