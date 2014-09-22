class CreateDiseaseJoinTables < ActiveRecord::Migration
  def change
    create_join_table :doctors, :diseases
    create_join_table :hospitals, :diseases
  end
end
