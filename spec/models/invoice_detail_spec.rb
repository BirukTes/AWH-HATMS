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

require 'rails_helper'

RSpec.describe InvoiceDetail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
