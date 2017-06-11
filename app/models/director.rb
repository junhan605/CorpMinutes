class Director < ApplicationRecord
  belongs_to :company
  # attr_accessible :director_attributes
  validates_presence_of :name
end
