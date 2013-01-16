class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :person_id

  belongs_to :person
  belongs_to :friend, :class_name => "Person"
end
