class AddClickCountToHospitals < ActiveRecord::Migration
  def change
    change_table :hospitals do |t|
      t.integer :click_count, default: 0
      t.index   :click_count
    end
  end
end
