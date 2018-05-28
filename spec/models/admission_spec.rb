# == Schema Information
#
# Table name: admissions
#
#  id                 :bigint(8)        not null, primary key
#  admissionDate      :datetime         not null
#  dischargeDate      :datetime
#  currentMedications :text
#  admissionNote      :text
#  ward_id            :bigint(8)
#  patient_id         :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  status             :string
#

require 'rails_helper'

RSpec.describe Admission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
