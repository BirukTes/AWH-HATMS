json.extract! ward, :id, :name, :wardNumber, :numberOfBeds, :bedStatus, :patientGender, :deptName, :isPrivate, :created_at, :updated_at
json.url ward_url(ward, format: :json)
