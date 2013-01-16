class Reservation < ActiveRecord::Base
  attr_accessible :person_id, :reservation_date, :wish_id

  belongs_to :person
  belongs_to :wish
end
