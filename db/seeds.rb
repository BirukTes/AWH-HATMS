# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# exit unless Rails.env.development?

# Saves the object to the db and the variable/or just db
# Method create with ! (create!), provides errors messages

# Seeding again due to errors, so commented out or retrieving from db

# puts 'Create job titles'
# JobTitle.create!(name: 'Medical Records Staff')
# As of seed of this there is already consultant
# jobTitleConsultantId = 1
# JobTitle.create!(title: 'Doctor')
# JobTitle.create!(title: 'Nurse Staff')
# JobTitle.create!(title: 'Nurse')
# JobTitle.create!(title: 'Ward Sister')

# puts 'Create/update specialities'
# Speciality.create!(speciality: 'Administration')
# specialityPaediatrics = Speciality.search(1).update_attributes!(speciality: 'Paediatrics')
# specialityPaediatricsId = 1
#
# specialityCoronaryId = 3
# Speciality.create!(speciality: 'Obstetrics')
# Speciality.create!(speciality: 'Cardiology')
# Speciality.create!(speciality: 'Orthopaedics')

# puts 'Create/update teams'
# Paediatrics already exists, and coronary, so assigning id numbers
# teamPaediatricsId = 1
# teamCoronaryId = 2


puts 'Create staffs'
# staffANini = Staff.new(email: 'anini@outlook.com', password: 'password', userId: 'anini', team_id: teamPaediatricsId)
#
# staffANini.specialisms.build(speciality_id: specialityPaediatricsId)
# staffANini.jobs.build(job_title_id: jobTitleConsultantId)
#
# staffANini.build_person(firstName: 'Aliza', lastName: 'Nini', dateOfBirth: '1985-03-09', gender: 'Female',
#                         telHomeNo: '0141656424', telMobileNo: '0734084054')
#
# staffANini.person.build_address(houseNumber: '20', street: 'Fulmar Ct', town: 'Surbiton', postcode: 'KT3 1JY')

#
# staffAJohn = Staff.new(email: 'ajohn@outlook.com', password: 'password', userId: 'ajohn', team_id: teamCoronaryId)
#
# staffAJohn.specialisms.build(speciality_id: specialityCoronaryId)
# staffAJohn.jobs.build(job_title_id: jobTitleConsultantId)
#
# staffAJohn.build_person(firstName: 'Adam', lastName: 'John', dateOfBirth: '1970-06-24', gender: 'Male',
#                         telHomeNo: '0141668787', telMobileNo: '0757784354')
#
# staffAJohn.person.build_address(houseNumber: '33', street: 'Britannia Rd', town: 'Surbiton', postcode: 'KT5 8LJ')
#
#
# puts 'Saving staff'
# # staffANini.save!
# staffAJohn.save!

# puts 'Create patients'
# patientCaitlin = Patient.create!(allergies: nil, diabetes: true, asthma: true, smokes: nil, alcoholic: nil, medicalTestsResults: nil,
#                                  nextOfKin: 'Albert Ellis, Grand Father, 020233343, UK', isPrivate: true)
#
# patientCaitlin.build_person(firstName: 'Caitlin ', lastName: 'Bowler', dateOfBirth: '1995/03/09', gender: 'Female',
#                             telHomeNo: '0141656424', telMobileNo: '0734084054')
#
# patientCain = Patient.create!(allergies: 'Dimetapp, Claritin', diabetes: true, asthma: true, smokes: nil, alcoholic: nil, medicalTestsResults: nil,
#                               nextOfKin: 'John Phelps, Father, 020233343, UK', isPrivate: nil)
#
# patientCain.build_person(firstName: 'Cain', lastName: 'Phelps', dateOfBirth: '2000/03/09', gender: 'Male',
#                          telHomeNo: '0141656424', telMobileNo: '0734084054')
#
#
# puts 'Create patient addresses'
# Address.create!(houseNumber: '36', street: 'King Charles RD', town: 'Surbiton', postcode: 'KT5 9BH', person_id: patientCaitlin.person.id)
# Address.create!(houseNumber: '33', street: 'Pine Gardens', town: 'Surbiton', postcode: 'KT5 7JY', person_id: patientCain.person.id)
#

# puts('Create wards')
# Ward.create!(name: 'Paediatrics Medical Block', wardNumber: '1', numberOfBeds: '20', bedStatus: nil, patientGender: 'Male', deptName: 'Paediatrics', isPrivate: nil)
# Ward.create!(name: '(Private) Paediatrics Medical Block', wardNumber: '1', numberOfBeds: '20', bedStatus: '20', patientGender: 'Male', deptName: 'Paediatrics', isPrivate: true)
# Ward.create!(name: 'Coronary Medical Block', wardNumber: '2', numberOfBeds: '10', bedStatus: '10', patientGender: 'Male', deptName: 'Coronary', isPrivate: nil)
# Ward.create!(name: '(Private) Coronary Medical Block', wardNumber: '', numberOfBeds: '10', bedStatus: '10', patientGender: 'Male', deptName: 'Coronary', isPrivate: true)
# Ward.create!(name: 'Coronary Medical Block', wardNumber: '3', numberOfBeds: '10', bedStatus: '10', patientGender: 'Female', deptName: 'Coronary', isPrivate: nil)
# Ward.create!(name: 'Orthopaedics Medical Block', wardNumber: '4', numberOfBeds: '10', bedStatus: '10', patientGender: 'Male', deptName: 'Orthopaedics', isPrivate: nil)
# Ward.create!(name: 'Cardiology Centre Block', wardNumber: '5', numberOfBeds: '12', bedStatus: '12', patientGender: 'Female', deptName: 'Cardiology', isPrivate: nil)
# Ward.create!(name: 'Obstetrics Princess Royal Maternity', wardNumber: '6', numberOfBeds: '24', bedStatus: '6', patientGender: 'Female', deptName: 'Obstetrics', isPrivate: nil)
# Ward.create!(name: 'Obstetrics Princess Royal Maternity', wardNumber: '7', numberOfBeds: '12', bedStatus: '7', patientGender: 'Female', deptName: 'Obstetrics', isPrivate: nil)

# Updated bed status
# Ward.all.each do |ward|
#   if ward.bedStatus == nil
#     ward.bedStatus = ward.numberOfBeds
#     ward.save!
#   end
# end