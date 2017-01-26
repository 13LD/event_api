class User < ActiveRecord::Base
  # Include default devise modules.
  acts_as_follower
  acts_as_followable

  validates_presence_of :email
  validates_presence_of :name

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :events
  has_many :comments

end
