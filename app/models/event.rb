class Event < ApplicationRecord
  mount_uploader :attachment, AvatarUploader
  belongs_to :user
  acts_as_followable

  include PublicActivity::Model
  tracked only: [:create, :like], owner: Proc.new{ |controller, model| model.user }

  validates_presence_of :name
  validates_presence_of :when
  validates_presence_of :user
end
