# frozen_string_literal: true

RSpec.describe 'Swishes', type: :request do
  let!(:user) { create(:user, phone_number: '1111111111', name: 'pungrattan') }
  let(:user_credentials) { user.create_new_auth_token }
  let(:user_headers) do
    { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials)
  end
  let!(:user2) { create(:user, name: 'possum', phone_number: '1231181189') }
  let!(:ping) { create(:ping, user_id: user2.id) }
  let!(:pong) { create(:pong, user_id: user.id, total_cost: '54 kr', status: 'accepted', ping_id: ping.id) }

  before do
    post '/swish',
         params: {
           swish: {
             total_cost: pong.total_cost,
             pong_id: pong.id
           }
         },
         headers: user_headers
  end

  it 'returns a 200 response status' do

    expect(response).to have_http_status 200
  end

  xit 'returns payment status' do
    expect(response_json['body']).to eq 'PAYMENT SUCCESSFUL'
  end
end
