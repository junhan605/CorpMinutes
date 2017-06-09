class Company < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :directors, :dependent => :destroy

  validates_presence_of :name
  validates_associated :directors

  accepts_nested_attributes_for :directors, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  after_update :save_directors

  def new_director_attributes=(director_attributes)
    director_attributes.each do |attributes|
      directors.build(attributes)
    end
  end

  def existing_director_attributes=(director_attributes)
    directors.reject(&:new_record?).each do |task|
      attributes = director_attributes[director.id.to_s]
      if attributes
        director.attributes = attributes
      else
        directors.delete(director)
      end
    end
  end

  def save_directors
    directors.each do |task|
      director.save(false)
    end
  end
end
