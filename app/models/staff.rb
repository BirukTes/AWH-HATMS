class Staff < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup many-to-many association through the corresponding join table
  has_many :jobs
  has_many :specialisms
  belongs_to :team

  attr_accessor :email, :password, :userId, :firstName, :lastName, :team_id, :gender, :dateOfBirth,
                :houseNumber, :street, :town, :postcode, :telNumber, :mobileNumber,
                :staff_id, :speciality_id, :staff_id, :job_title_id, :speciality, :jobTitle

  accepts_nested_attributes_for :specialisms, :jobs
end
