# Allows to the creation of invoices, has many invoice details, references admission and
#
# @author Bereketab Gulai

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

  # Nested fields
  accepts_nested_attributes_for(:invoice_details, allow_destroy: true)

  # Validations
  validates_associated(:invoice_details)
  validates(:dateDue, presence: true)
  validates(:amount, presence: true)

  # Humanises them using the data in en.yml
  human_attribute_name(:dateDue)
  human_attribute_name(:dateReceived)
end
