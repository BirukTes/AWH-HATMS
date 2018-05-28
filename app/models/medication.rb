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

class Medication < ApplicationRecord
  belongs_to :prescription
  belongs_to :drug
end
