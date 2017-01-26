class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :when, :place
end
