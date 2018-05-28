# == Schema Information
#
# Table name: invoices
#
#  id              :bigint(8)        not null, primary key
#  dateReceived    :date
#  dateDue         :date
#  paymentReceived :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admission_id    :bigint(8)
#  amount          :decimal(, )
#

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
