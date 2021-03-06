class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show, :new]

  def new
    @micropost = Micropost.new
  end

  def show
    @micropost = Micropost.find(params[:id])
    @reply = Reply.new
    @replies = @micropost.reply
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿に成功しました"
      redirect_to user_path @current_user.id
    else
      render new_micropost_path
    end
  end

  def destroy
    @micropost = current_user.microposts.find(params[:id])
    @micropost.destroy
    flash[:success] = "削除に成功しました。"
    redirect_to (user_path @current_user.id)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end
end
