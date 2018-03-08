class Event < ApplicationRecord
  validates :date, :image_link, :user_id, presence: true
  validates :name, length: {minimum: 5}, presence: true
  validates :description, length: {minimum: 10}, presence: true
  validates :organizer, length: {minimum: 5}, presence: true
end
