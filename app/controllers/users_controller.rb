class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    if !params[:search].blank?
      @users = @users.search(params[:search])
    end

    @count = @users.count
    @users = @users.paginate(per_page: params[:per_page], page: params[:page])
    render json: {users: @users, count: @count}
  end

  def show
    render json: @user
  end

  def update
    if @user.update_attributes(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def create
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: {}
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    #current user can't create a user of a higher role.
    role = params[:user][:role]
    if role
      if User::roles[role] > User::roles[current_user.role]
        logger.warn("Reducing #{role} to #{current_user.role}")
        params[:user][:role] = current_user.role
      end
    end

    case action_name
      when "update"
        if params[:user][:password].blank?
          params[:user].delete("password")
          params[:user].delete("confirmPassword")
        end
        params.require(:user).permit(:email, :password, :first_name, :last_name, :address, :phone, :role)
      when "create"
        params.require(:user).require(:email)
        params.require(:user).require(:password)
        params.require(:user).require(:role)
        params.require(:user).permit(:email, :password, :first_name, :last_name, :role, :address, :phone)
    end
  end

end
