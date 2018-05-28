# == Schema Information
#
# Table name: medications
#
#  id              :bigint(8)        not null, primary key
#  prescription_id :bigint(8)
#  drug_id         :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Medication, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
