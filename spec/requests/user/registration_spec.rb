# frozen_string_literal: true

RSpec.describe 'POST /auth', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'with valid credentials' do
    let!(:community) { create(:community)}
    before do
      post '/auth',
        params: {
          email: 'user@mail.com',
          name: 'Betty',
          password: 'password',
          password_confirmation: 'password',
          community_id: community.id,
          phone_number: '123456789',
          address: 'Superstreet 1'
        },
        headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns a success message' do
      expect(response_json['status']).to eq 'success'
    end

    it 'assign user to correct community' do
      user= User.last
      expect(user.community).to eq community
    end
  end

  context 'when a user submits' do
    describe 'a non-matching password confirmation' do
      before do
        post '/auth',
          params: {
            email: 'user@mail.com',
            password: 'password',
            password_confirmation: 'wrong_password'
          },
          headers: headers
      end

      it 'returns a 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'returns an error message' do
        expect(response_json['errors']['password_confirmation']).to eq ["doesn't match Password"]
      end
    end

    describe 'an invalid email address' do
      let!(:community) { create(:community)}
      before do
        post '/auth',
          params: {
            email: 'user@mail',
            password: 'password',
            password_confirmation: 'password'
          },
          headers: headers
      end

      it 'returns a 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'returns an error message' do
        expect(response_json['errors']['email']).to eq ['is not an email']
      end
    end

    describe 'an already registered email' do
      let!(:registered_user) { create(:user, email: 'otherUser@mail.com') }

      before do
        post '/auth',
          params: {
            email: 'otherUser@mail.com',
            password: 'password',
            password_confirmation: 'password'
          },
          headers: headers
      end

      it 'returns a 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'returns an error message' do
        expect(response_json['errors']['email']).to eq ['has already been taken']
      end
    end
  end

  describe 'an invalid email address' do
    before do
      post '/auth',
        params: {
          email: 'user@mail',
          password: 'password',
          password_confirmation: 'password',
          name: ''
        },
        headers: headers
    end

    it 'returns a 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns an error message' do
      expect(response_json['errors']['name']).to eq ["can't be blank"]
    end
  end
end
