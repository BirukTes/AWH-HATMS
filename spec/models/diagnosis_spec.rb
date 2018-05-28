# == Schema Information
#
# Table name: diagnoses
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  description  :string
#  admission_id :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Diagnosis, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
