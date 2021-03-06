class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy, :password_edit, :password_update, :following, :followers]
  before_action :correct_user, only: [:edit, :update, :destroy, :password_edit, :password_update]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "登録に成功しました!"
      log_in @user
      redirect_to @user
    else
      render 'users/new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "更新に成功しました！"
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    log_out
    redirect_to root_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  # passwordの更新と他のユーザー情報の更新を分けた場合はストロングパラメータも分けたほうがいいのかな？
  # ユーザーのsign-up(#create)で使われているので、passwordがないとユーザーを登録できないので必要
  def user_params
    if params[:user][:email] = ""
      params[:user][:email] = nil
    end
    params.require(:user).permit(:name, :user_name, :email, :self_introduction,
                                 :phonenumber, :gender, :profile_picture,
                                 :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user == current_user
  end
end
