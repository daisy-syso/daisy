namespace :join_table do

  desc "Update join tables"
  task :update => :environment do
    count, n = Diseases::Disease.count, 0
    Diseases::Disease.all.each do |disease|
      # puts "  #{disease.name} ( #{n+=1} / #{count} )" 
      doctors = Hospitals::Doctor.where(
        Hospitals::Doctor.arel_table[:desc].matches("%#{disease.name}%"))
      disease.doctors = doctors
      disease.hospitals = doctors.includes(:hospital).map(&:hospital).compact
      disease.save
    end
  end
end
