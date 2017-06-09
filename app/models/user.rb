class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #, :confirmable


  has_and_belongs_to_many :companies
 	accepts_nested_attributes_for :companies

  def has_companies?
	  errors.add(:companies, "must be specified.") if self.companies.blank?
	end

  def generated_password
    new_password = Devise.friendly_token.first(8)
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

end
