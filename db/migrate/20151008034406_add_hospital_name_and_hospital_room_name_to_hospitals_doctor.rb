class AddHospitalNameAndHospitalRoomNameToHospitalsDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :hospital_name, :string
    add_column :doctors, :hospital_room_name, :string
  end
end
