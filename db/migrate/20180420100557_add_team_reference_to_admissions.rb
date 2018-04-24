class AddTeamReferenceToAdmissions < ActiveRecord::Migration[5.1]
  def change
    add_reference :admissions, :team, foreign_key: true
  end
end
