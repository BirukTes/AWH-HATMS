# == Schema Information
#
# Table name: patients
#
#  id                  :bigint(8)        not null, primary key
#  allergies           :string
#  diabetes            :boolean          default(FALSE)
#  asthma              :boolean          default(FALSE)
#  smokes              :boolean          default(FALSE)
#  alcoholic           :boolean          default(FALSE)
#  medicalTestsResults :text
#  nextOfKin           :text
#  isPrivate           :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  email               :string
#  occupation          :string
#

require 'rails_helper'

RSpec.describe Patient, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
