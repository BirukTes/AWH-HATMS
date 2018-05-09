class Invoice < ApplicationRecord
  belongs_to :patient
  has_many(:invoice_details, dependent: :destroy)

  validates_associated(:invoice_details)

  accepts_nested_attributes_for(:invoice_details, allow_destroy: true)

  validates(:date, presence: true)
  validates(:dateDue, presence: true)
end
