class Staff < ApplicationRecord
  # I use this class a point of reference for comment on association which may not be commented elsewhere
  #
  # Inverse of saves memory, allows creation of many children,
  # allows has many through by auto creating the necessary junction record

  # Explicitly state table name, as a subclass it has it own table too
  # This changes the table name where I can save where I can the attributes, but does not solve the issue
  # self.table_name = "staffs"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise(:database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:userId])

  # Setup many-to-many association through the corresponding join table
  # Through expects that junctions are declared
  has_many :specialisms
  has_many :jobs
  #
  has_many(:specialities, through: :specialisms)
  has_many(:job_titles, through: :jobs)

  # Association to team is nullable/optional
  belongs_to(:team, optional: true)

  # , attr_accessor.. was overriding attribute values for people
  #
  # attr_accessor (:email, :password, :userId, :firstName, :lastName, :team_id, :gender, :dateOfBirth,
  #               :houseNumber, :street, :town, :postcode, :telNumber, :mobileNumber)
  #
  # This method, declares and provides getter and setter for each symbol (variable)
  # attr_accessor(:email, :password, :userId, :team_id, :firstName, :lastName, :gender, :dateOfBirth,
  #               :houseNumber, :street, :town, :postcode, :telNumber, :mobileNumber,
  #               :jobTitle, :speciality, :team, :job)

  # Association with Person class, as polymorphic
  has_one(:person, as: :personalDetail, dependent: :destroy)

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
  def admin?
    is_job?('Medical Records Staff')
  end

  def consultant?
    is_job?('Consultant')
  end

  def doctor?
    is_job?('Doctor')
  end

  private

  def is_job?(title)
    # Inverted value checking for if null, so
    # true => false, and  false => true
    # TODO may require refactor for multiple job titles to conclude true or false
    job_title.each.eql?(title)
  end

  def job_title
    # Returns an array of title attribute for each job title
    self.job_titles.map(&:title)
  end
end
