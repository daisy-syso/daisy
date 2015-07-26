class CreateCountries < ActiveRecord::Migration
  def change
    add_column :provinces, :country_id, :integer

    create_table :countries do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
