class RemoveTeamColumnReferenceOnAdmissions < ActiveRecord::Migration[5.1]
  def change
    remove_reference :admissions, :team, foreign_key: true
  end
end
