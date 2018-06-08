# General helper methods for application views
#
# @author Bereketab Gulai
module ApplicationHelper
  # Gets the Bootstrap alert class for given flash type
  #
  # @return [String] alert class
  def alert_class_helper(flash_type)
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
  def specialities_option
    Speciality.all.map do |speciality|
      # Hash [key, value]
      [speciality.speciality, speciality.id]
    end
  end

  # Gets the option for wards, T
  #
  # @return [[job title name, ward id]]
  def job_titles_option
    JobTitle.all.map do |job_title|
      [job_title.title, job_title.id]
    end
  end

  # Gets the option for wards
  #
  # @return [[team name, team id]]
  def teams_option
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

  # All but limited to 8
  def all_staffs
    Staff.all.limit(8)
  end

  # Staff option
  #
  # @return [[Array]] - option id and name
  def staffs_option (filter_by = nil)
    case filter_by
      when 'consultant'
        JobTitle.find_by(title: 'Consultant').staffs.each do |staff|
          unless staff.team
            ['(' + staff.userId + ')' + ' ' + staff.person.firstName + ' ' + staff.person.lastName, staff.userId]
          end
        end
        [] # return empty array
      else
        [] # return empty array
    end
  end

  # General method to get full name for the passed common class of Person
  #
  # @params [personal_detail_type] - any class that implements/has Person, current state either Patient/Staff
  # @return [string] - full name
  def person_full_name_helper(personal_detail_type)
    if personal_detail_type
      personal_detail_type.person.firstName + ' ' + personal_detail_type.person.lastName
    end
  end

  private

  # Maps wards to name and id
  #
  # @return [[ward name, ward id]] - Jagged Array
  def map_wards_option(wards)
    wards.map do |ward|
      [decorate_ward_name(ward), ward.id]
    end
  end

  # Decorate wards names to distinguish
  #
  # @return [String] - Decoration
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
