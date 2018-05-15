class Invoice < ApplicationRecord
  belongs_to :admission
  has_many(:invoice_details, dependent: :destroy)

  validates_associated(:invoice_details)

  accepts_nested_attributes_for(:invoice_details, allow_destroy: true)

  human_attribute_name(:dateDue)
  human_attribute_name(:dateReceived)

# validates(:date, presence: true)
  validates(:dateDue, presence: true)
  validates(:amount, presence: true)
end
