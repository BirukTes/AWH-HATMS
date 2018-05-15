json.patients do
  json.array!(@people_patients) do |person|
    json.name person.firstName + ' ' + person.lastName
    json.url patient_path(person.personalDetail_id)
  end
end

json.wards do
  json.array!(@wards) do |ward|
    json.name ward.name
    json.url ward_path(ward.id)
  end
end