json.extract! diagnosis, :id, :title, :description, :admission_id, :created_at, :updated_at
json.url diagnosis_url(diagnosis, format: :json)
