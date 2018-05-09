class InvoiceDetail < ApplicationRecord
  belongs_to :invoice
has_many :treatments

  validates(:treatment, presence: true)
  validates(:price, presence: true)
end
