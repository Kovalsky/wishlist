class Person < ActiveRecord::Base
  attr_accessible :birthday, :is_user, :name, :privacy_type, :role, :vk_avatar_url, :vk_id

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :wishes, :foreign_key => 'owner_id'
  has_many :reservation
  
  default_scope :order => 'is_user DESC'
end
