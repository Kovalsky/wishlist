class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.string :name
      t.string :url
      t.text :description
      t.integer :owner_id
      t.integer :rating

      t.timestamps
    end
  end
end
