# @author Bereketab Gulai
#
class Staff < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise(:database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:userId])

  # Setup many-to-many association through the corresponding join table
  # Through expects that junctions are declared
  has_many :specialisms
  has_many :jobs
  has_many(:specialities, through: :specialisms)
  has_many(:job_titles, through: :jobs)

  # Association to team is nullable/optional
  belongs_to(:team, optional: true)

  # Association with Person class, as polymorphic
  has_one(:person, as: :personalDetail, dependent: :destroy)

  # For nested forms
  accepts_nested_attributes_for(:specialisms, allow_destroy: true)
  accepts_nested_attributes_for(:jobs, allow_destroy: true)

  validates(:userId, presence: true, uniqueness: {case_sensitive: true})

  #
  # def will_save_change_to_email?
  #   true
  # end

  def resource_name
    :staff
  end

  # Job Titles as Roles
  def medical_staff_admin?
    is_job?('Medical Records Staff')
  end

  def consultant?
    is_job?('Consultant')
  end

  def doctor?
    is_job?('Doctor')
  end

  def staff_nurse?
    is_job?('Staff Nurse')
  end

  def nurse?
    is_job?('Nurse')
  end

  def ward_sister?
    is_job?('Ward Sister')
  end


  private


  # @param title the name of the job title
  # @return [boolean]
  def is_job?(title)
    # Loop through the returned titles and return when true is found
    title_attributes.each do |current_title|
      break if current_title.eql?(title)
    end
  end

  # @return [title:string]
  def title_attributes
    # Returns an array of title attribute for each job title
    self.job_titles.map(&:title)
  end
end
