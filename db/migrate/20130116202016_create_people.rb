class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.datetime :birthday
      t.string :vk_id
      t.string :privacy_type
      t.boolean :is_user
      t.string :vk_avatar_url
      t.string :role

      t.timestamps
    end
  end
end
