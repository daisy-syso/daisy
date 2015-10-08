namespace :redundancy do

  desc "redundancy tables columns"
  task :tables => :environment do

    # 医生类型
    puts "Starting Hospitals::Doctor"
    doctors = Hospitals::Doctor.where(hospital_name: nil)
    total = doctors.size
    doctors.each_with_index do |doctor, index|
      begin
        puts "#{index}/#{total}"
        hospital = Hospitals::Hospital.find(doctor.hospital_id)
        hospital_room = Hospitals::HospitalRoom.find(doctor.hospital_room_id)
        doctor.hospital_name = hospital.name
        doctor.hospital_room_name = hospital_room.name
        doctor.save
      rescue Exception => e
        puts e
      end
    end
    puts "Finished Hospitals::Doctor"

  end
end