class Event < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
  belongs_to :user
  acts_as_followable

  include PublicActivity::Model
  tracked only: [:create, :like], owner: Proc.new{ |controller, model| model.user }

  validates_presence_of :name
  validates_presence_of :when
  validates_presence_of :user
  validate :future_event


  private

  def future_event
    errors.add(:when, "Can't be in the past!") if when < Time.now
  end
end
