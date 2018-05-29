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


puts 'Create default job titles'
# Creates each in the order as in the array (0 = first...)

JobTitle.create!([{ title: 'Medical Records Staff' }, { title: 'Consultant' }, { title: 'Doctor' },
                  { title: 'Nurse Staff' }, { title: 'Nurse' }, { title: 'Ward Sister' }])

puts 'Create default specialities'
Speciality.create!([{ speciality: 'Administration' }, { speciality: 'Paediatrics' }, { speciality: 'Obstetrics' },
                    { speciality: 'Cardiology' }, { speciality: 'Orthopaedics' }, { speciality: 'Coronary' }])

puts 'Create default teams'
Team.create!([{ name: 'Administration', head: 'erice' }, { name: 'Paediatrics', head: 'anini' }, { name: 'Obstetrics', head: '' },
              { name: 'Cardiology', head: '' }, { name: 'Orthopaedics', head: '' }, { name: 'Coronary', head: '' }])

puts 'Create default staffs'
#--------------------------------------------------1
staff_E_Rice = Staff.new(email: 'erice@outlook.com', password: 'password', userId: 'erice', team_id: '1')

staff_E_Rice.specialisms.build(speciality_id: '1')
staff_E_Rice.jobs.build(job_title_id: '1')

staff_E_Rice.build_person(firstName: 'Erica', lastName: 'Rice', dateOfBirth: '1978-01-29', gender: 'Female',
                          telHomeNo: '080720735581', telMobileNo: '07720735581')

staff_E_Rice.person.build_address(houseNumber: '27', street: 'Fulmar Ct', town: 'Seltice Way', postcode: 'KT3 1JY')
#--------------------------1

#--------------------------2
staff_A_John = Staff.new(email: 'ajohn@outlook.com', password: 'password', userId: 'ajohn', team_id: '2')

staff_A_John.specialisms.build(speciality_id: '2')
staff_A_John.jobs.build(job_title_id: '3')

staff_A_John.build_person(firstName: 'Adam', lastName: 'John', dateOfBirth: '1982-06-24', gender: 'Male',
                          telHomeNo: '0141668787', telMobileNo: '0757784354')

staff_A_John.person.build_address(houseNumber: '33', street: 'Britannia Rd', town: 'Surbiton', postcode: 'KT5 8LJ')
#--------------------------2


#--------------------------3
staff_A_Nini = Staff.new(email: 'anini@outlook.com', password: 'password', userId: 'anini', team_id: '2')

staff_A_Nini.specialisms.build(speciality_id: '2')
staff_A_Nini.jobs.build(job_title_id: '2')

staff_A_Nini.build_person(firstName: 'Aliza', lastName: 'Nini', dateOfBirth: '1970-03-09', gender: 'Female',
                          telHomeNo: '0141656424', telMobileNo: '0734084054')

staff_A_Nini.person.build_address(houseNumber: '20', street: 'Fulmar Ct', town: 'Surbiton', postcode: 'KT3 1JY')
#--------------------------------------------------3

puts 'Saving default staff'
staff_E_Rice.save!
staff_A_Nini.save!
staff_A_John.save!

puts 'Create default patients'
#--------------------------------------------------1
patientCaitlin = Patient.new(allergies: nil, diabetes: true, asthma: true, smokes: nil, alcoholic: nil, medicalTestsResults: nil,
                             nextOfKin: 'Albert Ellis, Grand Father, 020233343, UK', isPrivate: true)

patientCaitlin.build_person(firstName: 'Caitlin ', lastName: 'Bowler', dateOfBirth: '1995/03/09', gender: 'Female',
                            telHomeNo: '0141656424', telMobileNo: '0734084054')

patientCain.person.build_address(houseNumber: '36', street: 'King Charles RD', town: 'Surbiton', postcode: 'KT5 9BH')
#-------------------------------1

#-------------------------------2
patientCain = Patient.new(allergies: 'Dimetapp, Claritin', diabetes: true, asthma: true, smokes: nil, alcoholic: nil, medicalTestsResults: nil,
                          nextOfKin: 'John Phelps, Father, 020233343, UK', isPrivate: nil)

patientCain.build_person(firstName: 'Cain', lastName: 'Phelps', dateOfBirth: '2000/03/09', gender: 'Male',
                         telHomeNo: '0141656424', telMobileNo: '0734084054')

patientCain.person.build_address(houseNumber: '33', street: 'Pine Gardens', town: 'Surbiton', postcode: 'KT5 7JY')
#-------------------------------------------------2


puts('Create default wards')
Ward.create!(name: 'Paediatrics Medical Block', wardNumber: '1', numberOfBeds: '20', bedStatus: '20', patientGender: 'Male', deptName: 'Paediatrics', isPrivate: false)
Ward.create!(name: 'Paediatrics Medical Block', wardNumber: '10', numberOfBeds: '20', bedStatus: '20', patientGender: 'Female', deptName: 'Paediatrics', isPrivate: false)
Ward.create!(name: 'Paediatrics Medical Block', wardNumber: '12', numberOfBeds: '20', bedStatus: '20', patientGender: 'Female', deptName: 'Paediatrics', isPrivate: true)
Ward.create!(name: 'Paediatrics Medical Block', wardNumber: '9', numberOfBeds: '20', bedStatus: '20', patientGender: 'Male', deptName: 'Paediatrics', isPrivate: true)

Ward.create!(name: 'Coronary Medical Block', wardNumber: '2', numberOfBeds: '10', bedStatus: '10', patientGender: 'Male', deptName: 'Coronary', isPrivate: false)
Ward.create!(name: 'Coronary Medical Block', wardNumber: '8', numberOfBeds: '10', bedStatus: '10', patientGender: 'Male', deptName: 'Coronary', isPrivate: true)
Ward.create!(name: 'Coronary Medical Block', wardNumber: '3', numberOfBeds: '10', bedStatus: '10', patientGender: 'Female', deptName: 'Coronary', isPrivate: false)
Ward.create!(name: 'Coronary Medical Block', wardNumber: '13', numberOfBeds: '10', bedStatus: '10', patientGender: 'Female', deptName: 'Coronary', isPrivate: true)

Ward.create!(name: 'Orthopaedics Medical Block', wardNumber: '4', numberOfBeds: '10', bedStatus: '10', patientGender: 'Male', deptName: 'Orthopaedics', isPrivate: false)
Ward.create!(name: 'Cardiology Centre Block', wardNumber: '5', numberOfBeds: '12', bedStatus: '12', patientGender: 'Female', deptName: 'Cardiology', isPrivate: false)

Ward.create!(name: 'Obstetrics Princess Royal Maternity', wardNumber: '6', numberOfBeds: '24', bedStatus: '24', patientGender: 'Female', deptName: 'Obstetrics', isPrivate: false)
Ward.create!(name: 'Obstetrics Princess Royal Maternity', wardNumber: '7', numberOfBeds: '12', bedStatus: '12', patientGender: 'Female', deptName: 'Obstetrics', isPrivate: true)
