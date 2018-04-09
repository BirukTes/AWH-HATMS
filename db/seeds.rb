# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
exit unless Rails.env.development?

# Saves the object to the db and the variable

put 'Create job titles'
jobTitleUsedHere = JobTitle.create!(name: "Medical Records Staff")
# No need to keep around
JobTitle.create!(name: "Consultant")
JobTitle.create!(name: "Doctor")
JobTitle.create!(name: "Nurse Staff")
JobTitle.create!(name: "Nurse")
JobTitle.create!(name: "Ward Sister")

puts 'Create a team'
# Other details will be auto filled, attributes #<Team id: nil, name: nil, head: nil, created_at: nil, updated_at: nil>
team = Team.create!(name: "Paediatrics", head: "AJohn")

puts 'Create a staff'
staff = Staff.create!(firstname: "Biruk", lastname: "Gulai", dateOfBirth: Time.now.to_date, telHomeNo: 0141656424, telMobileNo: 0734, gender: "Male", email: "bb@email.com", password: "b
bb999", userId: "bb", team: team, jobTitle: jobTitleUsedHere)

