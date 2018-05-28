# == Schema Information
#
# Table name: treatments
#
#  id           :bigint(8)        not null, primary key
#  date         :date
#  note         :text
#  issuedBy     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  admission_id :bigint(8)
#

require 'rails_helper'

RSpec.describe Treatment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
