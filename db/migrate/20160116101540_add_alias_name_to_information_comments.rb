class AddAliasNameToInformationComments < ActiveRecord::Migration
  def change
    add_column :information_comments, :alias_name, :string
  end
end
