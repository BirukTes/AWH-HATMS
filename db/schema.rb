# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180402124813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "town"
    t.string "postcode"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_addresses_on_person_id"
  end

  create_table "admissions", force: :cascade do |t|
    t.datetime "admissionDate", null: false
    t.datetime "dischargeDate"
    t.text "currentMedications"
    t.text "admissionNote"
    t.bigint "ward_id"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_admissions_on_patient_id"
    t.index ["ward_id"], name: "index_admissions_on_ward_id"
  end

  create_table "drugs", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_drugs_on_code"
  end

  create_table "job_titles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "staff_id"
    t.bigint "job_title_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_title_id"], name: "index_jobs_on_job_title_id"
    t.index ["staff_id"], name: "index_jobs_on_staff_id"
  end

  create_table "medications", force: :cascade do |t|
    t.bigint "prescription_id"
    t.bigint "drug_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drug_id"], name: "index_medications_on_drug_id"
    t.index ["prescription_id"], name: "index_medications_on_prescription_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "allergies"
    t.boolean "diabetes"
    t.boolean "asthma"
    t.boolean "smokes"
    t.boolean "alcoholic"
    t.text "medicalTestsResults"
    t.text "nextOfKin"
    t.boolean "isPrivate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.date "dateOfBirth"
    t.integer "telHomeNo"
    t.integer "telMobileNo"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prescriptions", force: :cascade do |t|
    t.date "date"
    t.string "dosage"
    t.integer "treatmentLength"
    t.string "issuedBy"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_prescriptions_on_patient_id"
  end

  create_table "specialisms", force: :cascade do |t|
    t.bigint "staff_id"
    t.bigint "speciality_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["speciality_id"], name: "index_specialisms_on_speciality_id"
    t.index ["staff_id"], name: "index_specialisms_on_staff_id"
  end

  create_table "specialities", force: :cascade do |t|
    t.string "speciality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "userId", null: false
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_staffs_on_email", unique: true
    t.index ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_staffs_on_team_id"
    t.index ["userId"], name: "index_staffs_on_userId", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "head"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treatments", force: :cascade do |t|
    t.date "date"
    t.text "note"
    t.string "issuedBy"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_treatments_on_patient_id"
  end

  create_table "wards", force: :cascade do |t|
    t.string "name"
    t.integer "wardNumber"
    t.integer "numberOfBeds"
    t.integer "bedStatus"
    t.string "patientGender"
    t.string "deptName"
    t.boolean "isPrivate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "people"
  add_foreign_key "admissions", "patients"
  add_foreign_key "admissions", "wards"
  add_foreign_key "jobs", "job_titles"
  add_foreign_key "jobs", "staffs"
  add_foreign_key "medications", "drugs"
  add_foreign_key "medications", "prescriptions"
  add_foreign_key "prescriptions", "patients"
  add_foreign_key "specialisms", "specialities"
  add_foreign_key "specialisms", "staffs"
  add_foreign_key "staffs", "teams"
  add_foreign_key "treatments", "patients"
end
