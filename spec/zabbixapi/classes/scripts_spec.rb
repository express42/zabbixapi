require 'spec_helper'

describe 'ZabbixApi::Scripts' do
  let(:scripts_mock) { ZabbixApi::Scripts.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { scripts_mock.method_name }

    it { is_expected.to eq 'script' }
  end

  describe '.identify' do
    subject { scripts_mock.identify }

    it { is_expected.to eq 'name' }
  end

  describe '.execute' do
    subject { scripts_mock.execute(data) }

    let(:data) { { scriptid: 222, hostid: 333 } }
    let(:result) { 'testresult' }

    before do
      allow(client).to receive(:api_request).with(
        method: 'script.execute',
        params: {
          scriptid: 222,
          hostid: 333
        }
      ).and_return(result)
    end

    it { is_expected.to eq result }
  end

  describe '.getscriptsbyhost' do
    subject { scripts_mock.getscriptsbyhost(data) }

    let(:data) { { scriptid: 222, hostid: 333 } }
    let(:result) { 'testresult' }

    before do
      allow(client).to receive(:api_request).with(
        method: 'script.getscriptsbyhosts',
        params: data
      ).and_return(result)
    end

    it { is_expected.to eq result }
  end
end
