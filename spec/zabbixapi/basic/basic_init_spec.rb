require 'spec_helper'

describe 'ZabbixApi::Basic' do
  let(:basic_mock) { ZabbixApi::Basic.new(client) }
  let(:client) { double }

  describe '.initialize' do
    subject { basic_mock }

    it 'sets passed client object as class variable' do
      expect(subject.instance_variable_get(:@client)).to eq client
    end
  end

  describe '.method_name' do
    subject { basic_mock.method_name }

    it 'raises an ApiError with message' do
      expect { subject }.to raise_error(ZabbixApi::ApiError, "Can't call method_name here")
    end
  end

  describe '.default_options' do
    subject { basic_mock.default_options }

    it { is_expected.to be_empty }
  end

  describe '.keys' do
    subject { basic_mock.keys }

    let(:key) { 'test-key' }
    let(:expected) { 'test-keys' }

    before { allow(basic_mock).to receive(:key).and_return(key) }

    it { is_expected.to eq expected }
  end

  describe '.key' do
    subject { basic_mock.key }

    let(:key) { 'test-key' }
    let(:expected) { 'test-keyid' }

    before { allow(basic_mock).to receive(:method_name).and_return(key) }

    it { is_expected.to eq expected }
  end

  describe '.identify' do
    subject { basic_mock.identify }

    it 'raises an ApiError with message' do
      expect { subject }.to raise_error(ZabbixApi::ApiError, "Can't call identify here")
    end
  end
end
