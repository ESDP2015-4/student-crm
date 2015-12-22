class UsersController < ApplicationController
  before_action :authenticate_user!
  # Это применит авторизацию ко всем экшнам в этом контроллере
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction, :role_sort_column

  def index
    @users = User.search(params[:search]).joins(:roles).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)

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

  def role_filter
    @role = Role.find(params[:id])
    filtered = Role.find_by(name: "#{@role.name}")
    @users = filtered.users.search(params[:search]).order(role_sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def changes
    @user = User.find(params[:id])
    @audit = @user.audits
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
                                 :image,
                                 {:role_ids => []})
  end

  def sort_column
    # params[:sort] || "name"
    User.column_names.include?(params[:sort]) ? params[:sort] : 'role_id'
  end

  def role_sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_direction
    # params[:direction] || 'asc'
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

end
