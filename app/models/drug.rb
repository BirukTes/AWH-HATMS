# == Schema Information
#
# Table name: drugs
#
#  id         :bigint(8)        not null, primary key
#  code       :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Drug < ApplicationRecord
  has_many :medications
  has_many :prescriptions, through: :medications
end
