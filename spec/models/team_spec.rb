# == Schema Information
#
# Table name: teams
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  head       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Team, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
