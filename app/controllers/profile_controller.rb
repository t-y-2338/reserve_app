class ProfileController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  
  def show
    @user = current_user
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "プロフィールを編集しました"
      redirect_to users_profile_path
    else
      flash[:notice] = "プロフィールの編集に失敗しました"
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:avatar, :name, :introduction)
  end
end
