class AddSwfToVides < ActiveRecord::Migration
  def change
    add_column :videos, :swf, :string
  end
end
