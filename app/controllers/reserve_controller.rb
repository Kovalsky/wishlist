class ReserveController < ApplicationController
  before_filter :set_current_user

  protected
  def set_current_user
    if (current_user == nil)
      render 'landing/not_login'
    end
  end

  public

  def add_reserve
   r_wish = Wish.find(params[:id])
   reserve = Reservation.new(:wish => r_wish, :person_id => current_user.id, :friend_id => r_wish.owner_id)
   if reserve.save
     flash[:success] = "You reserved this wish successfully"
     redirect_to reserve_index_path
   else
     redirect_to r_wish
   end

  end

  def delete_reserve
   r_wish = Wish.find(params[:id])
   reserve = Reservation.find_by_wish_id(r_wish.id)
   if reserve.destroy
     flash[:success] = "You delete reserve from this wish successfully"
     redirect_to reserve_index_path
   else
     redirect_to r_wish
   end
  end


  def index
    @title = "List of your reserves"
    @user = current_user
    @reservations = Reservation.where(:person_id => @user.id)
  end

  def create

  end

end
