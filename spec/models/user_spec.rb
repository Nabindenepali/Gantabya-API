require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create(:user) }

  describe 'responds to methods' do
    context 'when the fields are valid' do
      it 'responds to email' do
        expect(user).to respond_to(:email)
      end

      it 'responds to password' do
        expect(user).to respond_to(:password)
      end

      it 'is valid' do
        expect(user).to be_valid
      end

      it { should respond_to(:auth_token) }
    end
  end

  describe 'Validations for the user model' do
    context 'given the correct confirmation password' do
      it { should validate_confirmation_of(:password) }
    end

    context 'given a unique auth token' do
      it { should validate_uniqueness_of(:auth_token) }
    end
  end

  describe '#generate_authentication_token!' do
    context 'when there is no previous token' do
      it 'generates a unique token' do
        user.generate_authentication_token!
        expect(User.exists?(auth_token: user.auth_token)).to be_falsey
      end
    end

    context 'when a token has already been taken' do
      it 'generates a different token' do
        existing_user = FactoryBot.create(:user, auth_token: 'auniquetoken123')
        user.generate_authentication_token!
        expect(user.auth_token).not_to eql existing_user.auth_token
      end
    end
  end

  it { should have_many(:events) }

  describe '#products association' do

    before do
      user.save
      3.times { FactoryBot.create :event, user: user }
    end

    it 'destroys the associated events on self destruct' do
      events = user.events
      user.destroy
      events.each do |event|
        expect(Event.find(event.id)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end


