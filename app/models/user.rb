class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :companies
 	accepts_nested_attributes_for :companies

  def has_companies?
	  errors.add(:companies, "must be specified.") if self.companies.blank?
	end
end
