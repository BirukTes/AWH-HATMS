class Find::FindRegisteredPatient
  include ActiveModel::Model

  attr_accessor(:dateOfBirth, :lastName)

  validates :dateOfBirth, presence: true
  validates :lastName, presence: true

  def search(dateOfBirth, lastName)

  end
end