# frozen_string_literal: true

RSpec.describe 'DELETE /pongs/:id' do
  let(:user) { create(:user, role: 'user', community_status: 'accepted') }
  let(:user_credentials) { user.create_new_auth_token }
  let(:user_headers) do
    { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials)
  end
  let(:ping) { create(:ping) }
  let!(:pong) { create(:pong, ping_id: ping.id, user_id: user.id, active: false, status: 'accepted') }
  let!(:pong2) { create(:pong, ping_id: ping.id, user_id: user.id) }

  describe 'user can cancel their request' do
    before do
      delete "/pongs/#{user.id}",
             headers: user_headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'destroys request' do
      expect(User.find(user.id).pongs.last).not_to eq pong2.id
    end

    it 'returns success message' do
      expect(response_json['message']).to eq 'Your request is removed'
    end
  end
end
