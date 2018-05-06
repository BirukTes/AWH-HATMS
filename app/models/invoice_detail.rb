class InvoiceDetail < ApplicationRecord
  belongs_to :invoice

  validates(:treatment, presence: true)
  validates(:price, presence: true)
end
