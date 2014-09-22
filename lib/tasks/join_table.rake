namespace :join_table do

  desc "Update join tables"
  task :update => :environment do
    Diseases::Disease.all.each do |disease|
      doctors = Hospitals::Doctor.where(
        Hospitals::Doctor.arel_table[:desc].matches("%#{disease.name}%"))
      disease.doctors = doctors
      disease.hospitals = doctors.map(&:hospital)
      disease.save
    end
  end
end
