# frozen_string_literal: true

# == Schema Information
#
# Table name: staffs
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  userId                 :string           not null
#  team_id                :bigint(8)        not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  active                 :boolean          default(FALSE), not null
# @author Bereketab Gulai
#
#
# Defines a staff, having relationship with Person(parent at database level), Job Title(role),
# Speciality, Team(Can be owner), others include join tables
#
# Implement Devise for authentication, using user id and password, and +active+ status
class Staff < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable,
  # not using :registerable, instead custom staffs
  #
  # Registerable is disabled, there is custom controller for registering Staff
  #
  # Authentication keys changes the login identifier, userId, original email
  devise(:database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, authentication_keys: [:userId])

  # Association to team is nullable/optional
  belongs_to(:team, optional: true)

  # Association with Person class, as polymorphic
  has_one(:person, as: :personalDetail, dependent: :destroy)

  # Setup many-to-many association through the corresponding join table
  # Through expects that junctions are declared
  has_many(:specialisms, dependent: :destroy)
  has_many(:jobs, dependent: :destroy)
  has_many(:specialities, through: :specialisms)
  has_many(:job_titles, through: :jobs)


  # For nested forms
  # Use for additional validations, reject_if: proc { |attributes| attributes[:attribute].blank? }
  accepts_nested_attributes_for(:specialisms, allow_destroy: true)
  accepts_nested_attributes_for(:jobs, allow_destroy: true)
  accepts_nested_attributes_for(:person, update_only: true, allow_destroy: true)


  validates_associated :person, presence: true
  validates_associated(:specialisms, presence: true)
  validates_associated(:jobs, presence: true)
  validates(:userId, presence: true, uniqueness: { case_sensitive: true })

  # Provides access to the parent methods, or the class person, not working
  # delegate(:firstName, :lastName, to: :person, prefix: :pd)


  # Gets the first job title of the staff
  #
  # @return [title:string]
  def role_name
    # First one only for now
    staff_job_titles[0]
  end

  # Job Titles as Roles
  #
  # @return [true/false:boolean]
  def medical_staff_admin?
    is_job?('Medical Records Staff')
  end

  # @return [true/false:boolean]
  def consultant?
    is_job?('Consultant')
  end

  # @return [true/false:boolean]
  def doctor?
    is_job?('Doctor')
  end

  # @return [true/false:boolean]
  def staff_nurse?
    is_job?('Staff Nurse')
  end

  # @return [true/false:boolean]
  def nurse?
    is_job?('Nurse')
  end

  # @return [true/false:boolean]
  def ward_sister?
    is_job?('Ward Sister')
  end

  # Method to only authenticated active staff
  #
  # @return [true/false:boolean]
  def active_for_authentication?
    # Uncomment the below debug statement to view the properties of the returned self model values.
    # logger.debug self.to_yaml

    # Add active condition to existing base
    super && active?
  end

  # Sets the timeout length for Devise TimeOutable
  #
  # @return [Time] In minutes (30)
  def timeout_in
    30.minutes
  end

  private

  # Checks if any of the passed in matches the job titles of this staff
  #
  # @param title the name of the job title
  #
  # @return [boolean]
  def is_job?(title)
    # Loop through the returned titles and return when true is found
    staff_job_titles.each do |current_title|
      return true if current_title.eql?(title)
    end

    # Otherwise return false
    false
  end

  # Gets the job titles of this staff
  #
  # @return [titles:array]
  def staff_job_titles
    # Only the title attribute
    job_titles.map(&:title)
  end
end
