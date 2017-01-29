class Event < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
  belongs_to :user
  acts_as_followable
  acts_as_commentable
  
  include PublicActivity::Model
  tracked only: [:create, :like], owner: Proc.new{ |controller, model| model.user }

  validates_presence_of :name
  validates_presence_of :user
  validates :purpose, length: { maximum: 500 }

  has_many :comments
end
