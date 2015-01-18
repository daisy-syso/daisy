class FilterOfHospital < Settingslogic
  source "#{Rails.root}/config/filter_of_hospital.yml"
  namespace Rails.env
end