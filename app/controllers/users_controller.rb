class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:name,
                                 :surname,
                                 :middlename,
                                 :gender,
                                 :birthdate,
                                 :phone1,
                                 :phone2,
                                 :skype,
                                 :passportdetails,
                                 :email,
                                 :image
    )
  end
end