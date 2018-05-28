# == Schema Information
#
# Table name: prescriptions
#
#  id              :bigint(8)        not null, primary key
#  date            :date
#  dosage          :string
#  treatmentLength :integer
#  issuedBy        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  diagnosis_id    :bigint(8)
#

require 'rails_helper'

RSpec.describe Prescription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
