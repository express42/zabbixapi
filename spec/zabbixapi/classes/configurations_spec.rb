require 'spec_helper'

describe 'ZabbixApi::Configurations' do
  let(:configurations_mock) { ZabbixApi::Configurations.new(client) }
  let(:client) { double }

  describe '.array_flag' do
    subject { configurations_mock.array_flag }

    it { is_expected.to be_truthy }
  end

  describe '.method_name' do
    subject { configurations_mock.method_name }

    it { is_expected.to eq 'configuration' }
  end

  describe '.identify' do
    subject { configurations_mock.identify }

    it { is_expected.to eq 'host' }
  end

  describe '.export' do
    subject { configurations_mock.export(data) }

    let(:data) { { testdata: 222 } }
    let(:result) { { test: 1 } }

    before do
      allow(client).to receive(:api_request).with(
        method: 'configuration.export',
        params: data
      ).and_return(result)
    end

    it { is_expected.to eq result }
  end

  describe '.import' do
    subject { configurations_mock.import(data) }

    let(:data) { { testdata: 222 } }
    let(:result) { { test: 1 } }

    before do
      allow(client).to receive(:api_request).with(
        method: 'configuration.import',
        params: data
      ).and_return(result)
    end

    it { is_expected.to eq result }
  end
end
