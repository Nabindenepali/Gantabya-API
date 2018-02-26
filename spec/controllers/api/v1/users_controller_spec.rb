require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  let(:user) {create(:user)}
  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

  describe "GET #show" do
    before { get :show, params: {id: user.id}, format: :json }

    it "returns the information about a reporter on a hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql user.email
    end

    it { should respond_with 200 }
  end

end
