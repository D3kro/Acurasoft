class User < ApplicationRecord
  attr_accessor :login


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)

    # Assuming login can be either NIT or email
    nit_value = login.strip.to_i  # Convert to integer

    where(conditions).where(
      [ '"NIT" = :nit_value OR lower(email) = :email_value',
        { nit_value: nit_value, email_value: login.strip.downcase } ]
    ).first
  end
end
