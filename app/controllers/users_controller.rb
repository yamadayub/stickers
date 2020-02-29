class UsersController < ApplicationController

  def signup
    @user = User.new()
    render '/signup'
  end
  
  def create
    user = User.new(user_params)
    if user.save
      flash[:success] = 'ユーザー登録に成功しました。'
      redirect_to index
    else
      flash[:danger] = 'ユーザー登録に失敗しました。'
      render signup
    end
  end
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
  
end
