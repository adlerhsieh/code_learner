class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account
      t.string :password
      t.string :original_password
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
