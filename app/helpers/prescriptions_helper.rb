module PrescriptionsHelper
  def drug_options
    # Remove the drugs which cannot be used again for today
    if !@patient.prescriptions.all.empty?
      @patient.prescriptions.all.each_with_index do |p, index|
        # binding.pry
        if p.date == Date.today
          # Return all the drugs excluding the drugs used this day,
          # Map them to name as key and id as value, limit to 10
          return Drug.where.not(id: p.drugs).all.limit(10).map do |drug|
            [drug.name, drug.id]
          end
        elsif index == @patient.prescriptions.all.size - 1
          return get_all_drugs
        end
      end
    else
      get_all_drugs
    end
  end

  private

  def get_all_drugs
    # Otherwise return all, limit to 10
    Drug.all.limit(10).map do |drug|
      [drug.name, drug.id]
    end
  end
end
