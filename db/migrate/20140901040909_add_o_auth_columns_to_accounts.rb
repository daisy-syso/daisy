class AddOAuthColumnsToAccounts < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.string :provider
      t.string :uid
    end
  end
end
