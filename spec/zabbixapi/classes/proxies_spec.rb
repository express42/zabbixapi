require 'spec_helper'

describe 'ZabbixApi::Proxies' do
  let(:proxies_mock) { ZabbixApi::Proxies.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { proxies_mock.method_name }

    it { is_expected.to eq 'proxy' }
  end

  describe '.identify' do
    subject { proxies_mock.identify }

    it { is_expected.to eq 'host' }
  end

  describe '.delete' do
    subject { proxies_mock.delete(data) }

    let(:data) { { testidentify: 222 } }
    let(:result) { { 'proxyids' => ['1'] } }
    let(:identify) { 'testidentify' }
    let(:method_name) { 'testmethod' }

    before do
      allow(proxies_mock).to receive(:log)
      allow(proxies_mock).to receive(:identify).and_return(identify)
      allow(proxies_mock).to receive(:method_name).and_return(method_name)
      allow(client).to receive(:api_request).with(
        method: 'proxy.delete',
        params: data
      ).and_return(result)
    end

    context 'when result is not empty' do
      it 'returns the id of first proxy' do
        expect(subject).to eq 1
      end
    end

    context 'when result is empty' do
      let(:result) { [] }

      it { is_expected.to be_nil }
    end
  end

  describe '.isreadable' do
    subject { proxies_mock.isreadable(data) }

    let(:data) { { testidentify: 222 } }
    let(:result) { true }
    let(:identify) { 'testidentify' }
    let(:method_name) { 'testmethod' }

    before do
      allow(proxies_mock).to receive(:log)
      allow(proxies_mock).to receive(:identify).and_return(identify)
      allow(proxies_mock).to receive(:method_name).and_return(method_name)
      allow(client).to receive(:api_request).with(
        method: 'proxy.isreadable',
        params: data
      ).and_return(result)
    end

    it { is_expected.to be(true).or be(false) }
  end

  describe '.iswritable' do
    subject { proxies_mock.iswritable(data) }

    let(:data) { { testidentify: 222 } }
    let(:result) { true }
    let(:identify) { 'testidentify' }
    let(:method_name) { 'testmethod' }

    before do
      allow(proxies_mock).to receive(:log)
      allow(proxies_mock).to receive(:identify).and_return(identify)
      allow(proxies_mock).to receive(:method_name).and_return(method_name)
      allow(client).to receive(:api_request).with(
        method: 'proxy.iswritable',
        params: data
      ).and_return(result)
    end

    it { is_expected.to be(true).or be(false) }
  end
end
