require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create(:event) }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:organizer) }
  it { should respond_to(:date) }
  it { should respond_to(:image_link) }

  it { should validate_presence_of :name }
  it { should validate_length_of :name }
  it { should validate_presence_of :description }
  it { should validate_length_of :description }
  it { should validate_presence_of :organizer }
  it { should validate_length_of :organizer }
  it { should validate_presence_of :date }
  it { should validate_presence_of :image_link }
  it { should validate_presence_of :user_id }
end
