class Allocation < ApplicationRecord
  self.primary_keys :ward, :team

  belongs_to :ward
  belongs_to :team
end
