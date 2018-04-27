class Allocation < ApplicationRecord
  belongs_to :ward
  belongs_to :team

  # https://apidock.com/rails/ActiveRecord/Validations/ClassMethods/validates_uniqueness_of
  # Unique ward id with constraint of team id, (3, 2) cannot again (3, 2)
  # but (3, 1) or else
  validates_uniqueness_of(:team_id, scope: :ward_id)
end
