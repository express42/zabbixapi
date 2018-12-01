require 'spec_helper'

describe 'ZabbixApi::Users' do
  let(:users_mock) { ZabbixApi::Users.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { users_mock.method_name }

    it { is_expected.to eq 'user' }
  end

  describe '.indentify' do
    subject { users_mock.indentify }

    it { is_expected.to eq 'alias' }
  end

  describe '.key' do
    subject { users_mock.key }

    it { is_expected.to eq 'userid' }
  end

  describe '.keys' do
    subject { users_mock.keys }

    it { is_expected.to eq 'userids' }
  end
<<<<<<< HEAD
=======

  describe '.add_medias' do
    subject { users_mock.add_medias(data) }

    let(:data) { { userids: [1234, 5678], media: 'testmedia' } }
    let(:result) { { 'mediaids' => ['111'], 'testindentify' => 1 } }

    before do
      allow(client).to receive(:api_request).with(
        method: 'user.addMedia',
        params: {
          users: data[:userids].map { |t| { userid: t } },
          medias: data[:media]
        }
      ).and_return(result)
    end

    context 'when api_request returns nil result' do
      let(:result) { nil }

      it { is_expected.to be_nil }
    end

    context 'when api_request doesn not return empty result' do
      it 'returns first mediaid' do
        expect(subject).to eq 111
      end
    end
  end

  describe '.update_medias' do
    subject { users_mock.update_medias(data) }

    let(:data) { { userids: [1234, 5678], media: 'testmedia' } }
    let(:result) { { 'userids' => ['111'], 'testindentify' => 1 } }

    before do
      allow(client).to receive(:api_request).with(
        method: 'user.updateMedia',
        params: {
          users: data[:userids].map { |t| { userid: t } },
          medias: data[:media]
        }
      ).and_return(result)
    end

    context 'when api_request returns nil result' do
      let(:result) { nil }

      it { is_expected.to be_nil }
    end

    context 'when api_request doesn not return empty result' do
      it 'returns first userid' do
        expect(subject).to eq 111
      end
    end
  end
>>>>>>> bd80b37... ETSOE-458: [ets_zabbixapi] Rspec for Client class and other remaining classes in zabbixapi/classes/ dir
end
