class Invoice < ApplicationRecord
  belongs_to :patient
  has_many(:invoice_details, dependent: :destroy)

  validates_associated(:invoice_details)

  validates(:date, presence: true)
  validates(:dateDue, presence: true)
end
