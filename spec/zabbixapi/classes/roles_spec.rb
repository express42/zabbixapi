require 'spec_helper'

describe 'ZabbixApi::Roles' do
  let(:roles_mock) { ZabbixApi::Roles.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { roles_mock.method_name }

    it { is_expected.to eq 'role' }
  end

  describe '.identify' do
    subject { roles_mock.identify }

    it { is_expected.to eq 'name' }
  end

  describe '.key' do
    subject { roles_mock.key }

    it { is_expected.to eq 'roleid' }
  end

  # describe '.add_role' do
  #   subject { roles_mock.add_role(data) }

  #   let(:data) { { userids: [123, 111], usrgrpids: [4, 5] } }
  #   let(:result) { { 'usrgrpids' => [9090] } }
  #   let(:key) { 'testkey' }
  #   let(:permission) { 3 }

  #   before do
  #     roles = data[:usrgrpids].map do |t|
  #       {
  #         userids: data[:userids],
  #         usrgrpid: t,
  #       }
  #     end
  #     allow(roles_mock).to receive(:log)
  #     allow(roles_mock).to receive(:key).and_return(key)
  #     allow(client).to receive(:api_request).with(
  #       method: 'usergroup.update',
  #       params: user_groups
  #     ).and_return(result)
  #   end

  #   context 'when returns result with roles' do
  #     it 'returns first roleid' do
  #       expect(subject).to eq 9090
  #     end
  #   end

  #   context 'when api returns nil result' do
  #     let(:result) { nil }

  #     it 'returns nil' do
  #       expect(subject).to be_nil
  #     end
  #   end
  # end

  # describe '.update_roles' do
  #   subject { roles_mock.update_users(data) }

  #   let(:data) { { userids: [123, 111], usrgrpids: [4, 5] } }
  #   let(:result) { { 'roleids' => [9090] } }
  #   let(:key) { 'testkey' }
  #   let(:permission) { 3 }

  #   before do
  #     roles = data[:roleids].map do |t|
  #       {
  #         userids: data[:userids],
  #         usrgrpid: t,
  #       }
  #     end
  #     allow(roles_mock).to receive(:log)
  #     allow(roles_mock).to receive(:key).and_return(key)
  #     allow(client).to receive(:api_request).with(
  #       method: 'usergroup.update',
  #       params: roles,
  #     ).and_return(result)
  #   end

  #   context 'when returns result with roles' do
  #     it 'returns first roleid' do
  #       expect(subject).to eq 9090
  #     end
  #   end

  #   context 'when api returns nil result' do
  #     let(:result) { nil }

  #     it 'returns nil' do
  #       expect(subject).to be_nil
  #     end
  #   end
  # end
end
