class Person < ApplicationRecord
  has_one :address
  # Polymorphic association creation
  belongs_to :personalDetail, polymorphic: true

  validates :firstName, presence: true
  validates :lastName, presence: true
  validates :gender, presence: true

end
