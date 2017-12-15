class AccountController < ApplicationController
  def index
    @user=User.find(1)
  end
  def edit
    @user = User.find(1)
    pregnant = params[:pregnant]
    feeding = params[:feeding]
    @user.update(pregnant: pregnant,feeding: feeding)
    @user.save

    redirect_to root_path
  end
end
