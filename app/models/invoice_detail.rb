class InvoiceDetail < ApplicationRecord
  belongs_to :invoice
  has_many :treatments

  human_attribute_name(:unitPrice)

  validates(:treatment, presence: true)
  validates(:quantity, presence: true)
  validates(:unitPrice, presence: true)
  validates(:tax, presence: true)
end
