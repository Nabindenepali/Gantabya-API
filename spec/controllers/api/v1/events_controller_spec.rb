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
    before do
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
      let(:invalid_event_attributes) { {name: 'Swimming Competition', description: 'National Level Swimming Competition'} }
      before do
        api_authorization_header user.auth_token
        post :create, params: { event: invalid_event_attributes }
      end

      it 'renders an errors json' do
        event_response = json_response
        expect(event_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be created' do
        event_response = json_response
        expect(event_response[:errors][:organizer]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe 'PUT/PATCH #update' do
    before do
      event = FactoryBot.create :event, user: user
      api_authorization_header user.auth_token
    end

    context 'when is successfully updated' do
      before do
        patch :update, params: { id: event.id,
                                 event: { description: 'A random event'} }
      end

      it 'renders the json representation for the updated event' do
        event_response = json_response
        expect(event_response[:description]).to eql 'A random event'
      end

      it { should respond_with 200 }
    end

    context 'when is not updated' do
      before do
        patch :update, params: { id: event.id,
                                 event: { description: 'event'} }
      end

      it 'renders an errors json' do
        event_response = json_response
        expect(event_response).to have_key(:errors)
      end

      it 'renders the json errors on why the event could not be updated' do
        event_response = json_response
        event_response[:errors][:description]
        expect(event_response[:errors][:description]).to include 'is too short (minimum is 10 characters)'
      end

      it { should respond_with 422 }
    end
  end
end
