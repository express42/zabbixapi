require 'spec_helper'

describe 'ZabbixApi::Users' do
  let(:users_mock) { ZabbixApi::Users.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { users_mock.method_name }

    it { is_expected.to eq 'user' }
  end

  describe '.keys' do
    subject { users_mock.keys }

    it { is_expected.to eq 'userids' }
  end

  describe '.key' do
    subject { users_mock.key }

    it { is_expected.to eq 'userid' }
  end

  describe '.indentify' do
    subject { users_mock.indentify }

    it { is_expected.to eq 'alias' }
  end
end
