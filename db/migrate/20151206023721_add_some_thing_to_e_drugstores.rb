class AddSomeThingToEDrugstores < ActiveRecord::Migration
  def change
    add_column :e_drugstores, :website, :string
    add_column :e_drugstores, :description, :string
  end
end
