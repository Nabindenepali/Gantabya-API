require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  let(:event) { create(:event) }

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
      expect(events_response[:events]).to have(4).items
    end

    it { should respond_with 200 }
  end
end
