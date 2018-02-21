require 'rails_helper'

describe User do
  let(:user) { create(:user) }

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
