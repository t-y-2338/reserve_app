class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:search, :show]
  
  def search
    @user = current_user
    if params[:keyword].present?
      @rooms = Room.where(['room_name LIKE? OR detail LIKE?', "%#{params[:keyword]}%", "%#{params[:keyword]}%"])
    elsif params[:area].present?
      @rooms = Room.where(['address LIKE?', "%#{params[:area]}%"])
    else
      @rooms = Room.order('created_at DESC')
    end
  end
  
  def own
    @user = current_user
    @rooms = Room.where(user_id: @user.id)
  end
  
  def new
    @user = current_user
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if @room.save
      flash[:notice] = "施設を登録しました"
      redirect_to  own_rooms_path
    else
      flash[:notice_alert] = "施設の登録に失敗しました"
      render "new"
    end
  end
  
  def show
    @user = current_user
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end
  
  def edit
    @user = current_user
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "施設情報を更新しました"
      redirect_to room_path
    else
      flash[:notice_alert] = "施設情報の更新に失敗しました"
      render "edit"
    end
  end
  
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設を削除しました"
    redirect_to search_rooms_path
  end
  
  protected
  
  def room_params
    params.require(:room).permit(:room_name, :detail, :price, :address, :image, :user_id)
  end
  
end