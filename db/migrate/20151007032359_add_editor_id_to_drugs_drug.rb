class AddEditorIdToDrugsDrug < ActiveRecord::Migration
  def change
    add_column :drugs, :editor_id, :integer

    add_index :drugs, :editor_id
  end
end
