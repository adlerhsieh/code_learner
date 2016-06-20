class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.integer :q
      t.text :description
      t.text :content

      t.timestamps null: false
    end
  end
end
