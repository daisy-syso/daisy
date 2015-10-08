namespace :redundancy do

  desc "redundancy tables columns"
  task :tables => :environment do

    # 医生类型
    puts "Starting Hospitals::Doctor"
    Hospitals::Doctor.all.offset(310437).each_with_index do |doctor, index|
      begin
        puts index
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