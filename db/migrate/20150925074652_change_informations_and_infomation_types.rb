class ChangeInformationsAndInfomationTypes < ActiveRecord::Migration
  def change
  	change_table :health_information_types do |t|
        t.integer   :parent_id
        t.timestamps
    end
  	change_table :health_informations do |t|
        t.text   :content
        t.float  :star
        t.integer :reviews_count
        t.timestamps
    end
  end
end
