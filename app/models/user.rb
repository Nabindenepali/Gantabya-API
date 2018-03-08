class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_uniqueness_of :auth_token, allow_blank: true

  before_create :generate_authentication_token!

  has_many :events, dependent: :destroy

  def generate_authentication_token!
    begin
      new_token = Devise.friendly_token
    end while User.exists?(auth_token: new_token)
    self.auth_token = new_token
  end
end
