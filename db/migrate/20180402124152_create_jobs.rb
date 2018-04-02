class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.references :staff, foreign_key: true
      t.references :job_title, foreign_key: true

      t.timestamps
    end
  end
end
