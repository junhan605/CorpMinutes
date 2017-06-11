class Minute < ApplicationRecord
  belongs_to :company
  validates_presence_of :minute_type, :location, :other_party, :escriibe_property
end
