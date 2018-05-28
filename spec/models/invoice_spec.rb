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

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
