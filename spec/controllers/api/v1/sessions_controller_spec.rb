require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'when correct credentials are given' do
      let(:credentials) { { email: user.email, password: '12345678' } }
      before { post :create, params: { session: credentials } }

      it 'returns the user record' do
        user.reload
        expect(json_response[:auth_token]).to eql user.auth_token
      end

      it { should respond_with 200 }
    end

    context 'when incorrect credentials are given' do
      let(:credentials) { { email: user.email, password: 'invalidpassword' } }
      before { post :create , params: { session: credentials } }

      it 'returns an errors json' do
        expect(json_response[:errors]).to eql 'Invalid email or password'
      end

      it { should respond_with 422 }
    end
  end
end
