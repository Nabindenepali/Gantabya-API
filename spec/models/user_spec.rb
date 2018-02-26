require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) {create(:user)}

  describe 'responds to methods' do

    context 'when the fields are valid' do

      it 'responds to email' do
        expect(user).to respond_to(:email)
      end

      it 'responds to password' do
        expect(user).to respond_to(:password)
      end

      it 'responds to be valid' do
        expect(user).to be_valid
      end

    end

  end

  describe 'Validations for the user model' do

    context 'given the correct confirmation password' do
      it { should validate_confirmation_of(:password) }
    end

  end

end


