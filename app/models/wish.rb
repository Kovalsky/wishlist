class Wish < ActiveRecord::Base
  attr_accessible :description, :name, :owner_id, :rating, :url

  belongs_to :owner, :class_name => 'Person'
  has_one :reservation
	default_scope :order => 'rating DESC'

  validates :name, :presence => true, :length => {:in => 2..50}
  validates :url, :presence => true, :format =>  {:with => /^((http|https|ftp):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix }
  validates :owner_id, :presence =>  true
  validates :rating, :presence => true, :inclusion => {:in => 1..5}
end
# == Schema Information
#
# Table name: wishes
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  url         :string(255)
#  description :text
#  owner_id    :integer
#  rating      :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

