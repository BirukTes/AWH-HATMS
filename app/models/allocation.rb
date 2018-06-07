# Provides junction between teams and wards
#
# @author Bereketab Gulai

# == Schema Information
#
# Table name: allocations
#
#  id         :bigint(8)        not null, primary key
#  ward_id    :bigint(8)
#  team_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Allocation < ApplicationRecord
  belongs_to :ward
  belongs_to :team

  # https://apidock.com/rails/ActiveRecord/Validations/ClassMethods/validates_uniqueness_of
  # Unique ward id with constraint of team id, (3, 2) cannot again (3, 2)
  # but (3, 1) or else
  validates_uniqueness_of(:team_id, scope: :ward_id)
end
