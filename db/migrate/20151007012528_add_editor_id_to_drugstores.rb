class AddEditorIdToDrugstores < ActiveRecord::Migration
  def change
    add_column :drugstores, :editor_id, :integer

    add_index :drugstores, :editor_id
  end
end
