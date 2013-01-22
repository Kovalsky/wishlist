# == Schema Information
#
# Table name: people
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  birthday            :datetime
#  vk_id               :string(255)
#  privacy_type        :string(255)
#  is_user             :boolean
#  vk_avatar_url       :string(255)
#  role                :string(255)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#
require "open-uri"

class Person < ActiveRecord::Base
  attr_accessible :birthday, :is_user, :name, :privacy_type, :role,
                  :vk_avatar_url, :vk_id, :updated_at, :avatar

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :wishes, :foreign_key => 'owner_id'
  has_many :reservation
  
  default_scope :order => 'is_user DESC'

  has_attached_file :avatar, :styles => { :big => "150x150", :medium => "100x100>", :small => "30x30>" }

  def self.find_for_vkontakte_oauth access_token, friends_hashes, current_user_hash
    if person = Person.where(:vk_id => current_user_hash[:uid].to_s, :is_user => true).first
       person
    else
	  if person = Person.where(:vk_id => current_user_hash[:uid].to_s, :is_user => false).first
	    person.update_attributes(:avatar => open(current_user_hash[:photo_max]), :is_user => true)
		Person.create_friends friends_hashes, person
		person
	  else
    		person = Person.create!(:is_user => true, :name => access_token.info.name, :birthday =>
    								if access_token.extra.raw_info.bdate == nil
    								  nil
    								else
	     						      if access_token.extra.raw_info.bdate.length > 5
	     						        DateTime.strptime(access_token.extra.raw_info.bdate, '%d.%m.%Y')
	     						      else
	     						        DateTime.strptime(access_token.extra.raw_info.bdate, '%d.%m')
	     						      end
    								end,
    								:vk_id => access_token.uid.to_s)
    	person.update_attributes(:avatar => open(current_user_hash[:photo_max]),
    							 :vk_avatar_url => current_user_hash[:photo_max])
		Person.create_friends friends_hashes, person
		person
	  end 
    end
  end 

  def self.create_friends friends_hashes, person
    friends_hashes.each do |hash|
      friend = Person.where(:vk_id => hash[:uid].to_s).first
	  if friend == nil
	     friend = Person.create!(:is_user => false, :name =>hash[:first_name] + " " + hash[:last_name], :birthday => 
	     						 if hash[:bdate] == nil
	     						   nil 
	     						 else
	     						   if hash[:bdate].length > 5
	     						     DateTime.strptime(hash[:bdate], '%d.%m.%Y')
	     						   else
	     						     DateTime.strptime(hash[:bdate], '%d.%m')
	     						   end 
	     						 end,
	     						 :vk_id => hash[:uid].to_s, :vk_avatar_url => hash[:photo_max])
	  end
	  Friendship.create!(:person_id => person.id, :friend_id => friend.id )
    end
  end
  
  def self.update_friends friends_hashes, person
    friends_in_db = person.friendships.collect {|f| f.friend}
    friends_in_db.each do |f|
      if !(friends_hashes.include? f)
         Friendship.where(:person_id => person.id, :friend_id => f.id ).destroy
      end
    end
    friends_hashes.each do |hash|
      friend = Person.where(:vk_id => hash[:uid].to_s).first
	  if friend == nil
	     friend = Person.create!(:is_user => false, :name =>hash[:first_name] + " " + hash[:last_name], :birthday => 
	     						 if hash[:bdate] == nil
	     						   nil 
	     						 else
	     						   if hash[:bdate].length > 5
	     						     DateTime.strptime(hash[:bdate], '%d.%m.%Y')
	     						   else
	     						     DateTime.strptime(hash[:bdate], '%d.%m')
	     						   end 
	     						 end,
	     						 :vk_id => hash[:uid].to_s, :vk_avatar_url => hash[:photo_max])
	     Friendship.create!(:person_id => person.id, :friend_id => friend.id )
	  else
		 friend.update_attributes(:name =>hash[:first_name] + " " + hash[:last_name], :birthday => 
	     						 if hash[:bdate] == nil
	     						   nil 
	     						 else
	     						   if hash[:bdate].length > 5
	     						     DateTime.strptime(hash[:bdate], '%d.%m.%Y')
	     						   else
	     						     DateTime.strptime(hash[:bdate], '%d.%m')
	     						   end 
	     						 end,
	     						 :vk_avatar_url => hash[:photo_max], :updated_at => DateTime.now)
	  end
    end
  end
end

