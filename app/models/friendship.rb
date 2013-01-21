class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :person_id

  belongs_to :person
  belongs_to :friend, :class_name => "Person"
end
# == Schema Information
#
# Table name: friendships
#
#  id         :integer         not null, primary key
#  person_id  :integer
#  friend_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

