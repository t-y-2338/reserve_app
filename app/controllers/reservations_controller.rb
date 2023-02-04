class ReservationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @rooms = Room.all
    @reservations = Reservation.where(user_id: @user.id)
  end
  
  def confirm
    @user = current_user
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)
    unless @reservation.valid?
      render 'rooms/show'
    end
  end
  
  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:notice] = "施設の予約が完了しました"
      redirect_to reservations_path
    else
      flash[:notice] = "施設の予約ができませんでした"
      render "confirm"
    end
  end
  
  def show
    @user = current_user
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
  end
  
  def edit
    @user = current_user
    @reservation = Reservation.find(params[:id])
  end
  
  def update
    @reservation = Reservation.find(params[:reservation][:id])
    if @reservation.update(update_params)
      flash[:notice] = "施設の予約情報を変更しました"
      redirect_to reservations_path
    else
      flash[:notice_alert] = "予約情報を正しく入力してください"
      render 'edit'
    end
  end
  
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "施設の予約を削除しました"
    redirect_to reservations_path
  end
  
  protected
  
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :people, :room_id, :stay_days, :total_price).merge(user_id: current_user.id) 
  end
  
  def update_params
    params.require(:reservation).permit(:start_date, :end_date, :people)
  end
end
