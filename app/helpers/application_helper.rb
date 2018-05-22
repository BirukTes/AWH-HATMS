# frozen_string_literal: true

module ApplicationHelper
  # Gets the Bootstrap class for given flash type
  #
  # @return [Bootstrap-Alert-Class]
  def alert_class(flash_type)
    case flash_type.to_sym
      when :notice
        'alert-success'
      when :alert
        'alert-warning'
      when :error
        'alert-danger'
    end
  end

  # Gets the option for wards
  #
  # @return [[ward name, ward id]]
  def speciality_options
    Speciality.all.map do |speciality|
      # Hash [key, value]
      [speciality.speciality, speciality.id]
    end
  end

  # Gets the option for wards, T
  #
  # @return [[job title name, ward id]]
  def job_title_options
    JobTitle.all.map do |job_title|
      [job_title.title, job_title.id]
    end
  end

  # Gets the option for wards
  #
  # @return [[team name, team id]]
  def teams_options
    Team.all.map do |team|
      [team.name, team.id]
    end
  end

  # Gets the option for wards
  #
  # @return [[ward name, ward id]]
  def wards_option(filter_by = nil, patient = nil)
    case filter_by
      when 'admission'
        map_wards_option(Ward.ward_options(patient))
      when 'wards_for_current_staff'
        map_wards_option(current_staff.team.wards)
      else
        map_wards_option(Ward.all)
    end
  end

  # Gets the option for patients
  #
  # @return [[patient name, patient id]]
  def patients_option
    Patient.all.limit(10).map do |patient|
      [patient.person.firstName + ' ' + patient.person.lastName, patient.id]
    end
  end

  def all_staffs
    Staff.all.limit(4)
  end

  private

  # Maps wards to name and id
  #
  # @return [[ward name, ward id]]
  def map_wards_option(wards)
    wards.map do |ward|
      [decorate_ward_name(ward), ward.id]
    end
  end

  def decorate_ward_name(ward)
    if !ward.isPrivate && ward.patientGender.eql?('Male')
      '(Male) ' + ward.name
    elsif ward.isPrivate && ward.patientGender.eql?('Male')
      '(Private, Male) ' + ward.name
    elsif !ward.isPrivate && ward.patientGender.eql?('Female')
      '(Female) ' + ward.name
    elsif ward.isPrivate && ward.patientGender.eql?('Female')
      '(Private, Female) ' + ward.name
    end
  end
end
