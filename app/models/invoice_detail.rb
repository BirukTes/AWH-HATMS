# Holds the details for a referenced invoice
#
# @author Bereketab Gulai

# == Schema Information
#
# Table name: invoice_details
#
#  id         :bigint(8)        not null, primary key
#  treatment  :string
#  unitPrice  :decimal(, )
#  invoice_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quantity   :integer
#  tax        :decimal(, )      default(0.0)
#  lineTotal  :decimal(15, 2)
#

class InvoiceDetail < ApplicationRecord
  belongs_to :invoice

  human_attribute_name(:unitPrice)

  # Validates all attributes
  validates(:treatment, presence: true)
  validates(:quantity, presence: true)
  validates(:unitPrice, presence: true)
  validates(:tax, presence: true)
end
