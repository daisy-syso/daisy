class CreateEditors < ActiveRecord::Migration
  def change
    create_table :editors do |t|
      t.string :email
      t.string :username
      t.string :telephone
      t.string :password_hash

      t.timestamps
    end
  end
end
