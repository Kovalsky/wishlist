class AddImageToWish < ActiveRecord::Migration
  def change
    add_attachment :wishes, :image
  end
end
