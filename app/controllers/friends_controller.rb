# encoding: utf-8
class FriendsController < ApplicationController
  before_filter :set_current_user
  before_filter :correct_friend, :only => :show

  protected

  def set_current_user
    if (current_user == nil)
      render 'landing/not_login'
    end
  end

  def correct_friend
    friend = current_user.friends.where(id: params[:id]).first
    redirect_to friends_path if friend == nil
  end

  public

  def index
    friends = current_user.friends
    @friends = friends.sort_by { |hsh| [hsh[:is_user] ? 0:1]}
  end
  
  def bdate_in_1_week
    @title = "Friends who have birthday in 1 week"
    @friends_1_week = Person.friends_1_week(current_user)
  end
  
  def bdate_in_2_weeks
    @title = "Friends who have birthday in 2 weeks"
    @friends_2_weeks = Person.friends_2_week(current_user)
  end
  
  def bdate_in_1_month
    @title = "Friends who have birthday in 1 month"
    @friends_1_month = Person.friends_1_month(current_user)
  end
  
  def bdate_unknown
    @title = "Friends who have birthday and we don't know when"
    @friends_unknown =  Person.friends_unknown(current_user)
  end
  
  def show
    @friend = Person.find(params[:id])
    @title = "Page by #{@friend.name}"
	  @wishes = Wish.where(:owner_id => params[:id])
    @days_till_bday = days_till_bday(@friend)
    current_user.friendships.where(:friend_id => params[:id]).first.update_attribute(:wish_num, @wishes.size)
  end


  def days_till_bday(friend)
    if friend.birthday == nil then return end
    d_now = DateTime.strptime(DateTime.now.to_s[5,DateTime.now.to_s.length],'%m-%d')
    bday = DateTime.strptime(friend.birthday.to_s[5, friend.birthday.to_s.length],'%m-%d')
    if (d_now == bday)
      'сегодня'
    else
      if (bday > d_now)
        count = (bday - d_now).to_int
        '( через ' + count.to_s + ' '+ Russian.p(count,'день','дня','дней','дня') + ' )'
      else
        count = 365 - (d_now - bday).to_int
        '( через ' + count.to_s + ' '+ Russian.p(count,'день','дня','дней','дня') + ' )'
      end
    end
  end
    
end
