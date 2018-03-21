class Event < ApplicationRecord
  # attr_accessor :name, :description, :organizer, :date, :image

  validates :date, :user_id, presence: true
  validates :name, length: {minimum: 5}, presence: true, uniqueness: true
  validates :description, length: {minimum: 10}, presence: true
  validates :organizer, length: {minimum: 5}, presence: true

  belongs_to :user
  mount_uploader :image, ImageUploader

  def without_image
    { id: id, name: name, description: description, organizer: organizer, date: date }
  end
end
