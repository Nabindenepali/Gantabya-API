require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  let(:event) { create(:event) }
  let(:user) { create(:user) }

  describe 'GET #show' do
    before { get :show, params: { id: event.id } }

    it 'returns the information about a reporter on a hash' do
      event_response = json_response
      expect(event_response[:name]).to eql event.name
    end

    it { should respond_with 200 }
  end

  describe 'GET #index' do
    before(:each) do
      4.times { FactoryBot.create :event }
      get :index
    end

    it 'returns 4 records from the database' do
      events_response = json_response
      expect(events_response.length).to eql(4)
    end

    it { should respond_with 200 }
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      let(:event_attributes) { FactoryBot.attributes_for :event }
      before do
        api_authorization_header user.auth_token
        post :create, params: { event: event_attributes }
      end

      it 'renders the json representation for the event record just created' do
        event_response = json_response
        expect(event_response[:name]).to eql event_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context 'when is not created' do
      let(:invalid_event_attributes) { {title: 'Smart TV', price: 'Twelve dollars'} }
      before(:each) do
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, product: invalid_event_attributes }
      end

      it 'renders an errors json' do
        event_response = json_response
        expect(event_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be created' do
        event_response = json_response
        expect(event_response[:errors][:description]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
end
