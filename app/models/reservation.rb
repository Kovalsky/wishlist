class Reservation < ActiveRecord::Base
  attr_accessible :person_id, :reservation_date, :wish_id

  belongs_to :person
  belongs_to :wish
end
# == Schema Information
#
# Table name: reservations
#
#  id               :integer         not null, primary key
#  wish_id          :integer
#  person_id        :integer
#  reservation_date :datetime
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

