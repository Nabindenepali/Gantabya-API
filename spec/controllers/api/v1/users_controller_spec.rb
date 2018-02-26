require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  before {request.headers['Accept'] = "application/vnd.marketplace.v1"}

  describe "GET #show" do
    context "when valid user id is passed" do
      let(:user) { create(:user) }
      before { get :show, params: { id: user.id }, format: :json }

      it "returns the information about a reporter on a hash" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql user.email
      end

      it {should respond_with 200}
    end
  end

  describe "POST #create" do
    context "when valid user parameters are passed" do
      let(:valid_user_attributes) { FactoryBot.attributes_for :user }
      before { post :create, params: { user: valid_user_attributes }, format: :json }

      it "renders the json representation for the user record just created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql valid_user_attributes[:email]
      end

      it {should respond_with 201}
    end

    context "when invalid user parameters are passed" do
      let(:invalid_user_attributes) {{ password: "12345678",
                                       password_confirmation: "12345678" }}
      before { post :create, params: { user: invalid_user_attributes }, format: :json }

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it {should respond_with 422}
    end
  end

  describe "PUT/PATCH #update" do
    let(:user) { create(:user) }
    context "when the user exists and valid user parameters are passed" do
      before { put :update, params: { id: user.id, user: { email: 'newmail@example.com' } }, format: :json }

      it "renders the json representation of updated user" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql 'newmail@example.com'
      end

      it { should respond_with 200 }
    end

    context "when the user exists but invalid email is passed" do
      before { put :update, params: { id: user.id, user: { email: 'badmail.com' } }, format: :json }

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "returns an error specifying entered email was invalid" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include 'is invalid'
      end

      it { should respond_with 422 }
    end
  end
end
