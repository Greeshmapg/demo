class UsersController < ApplicationController

  # def custom_new
  #   @user = User.new
  #   @team = Team.find(params[:id])
  # end

  def show
    @user = User.find(params[:id])
  end

  def custom_create
    @user_email = params[:user][:email]
    @check_user = User.find_by(email: @user_email)
    @team = Team.find(params[:id])
    @user = User.new(user_params)
    @role = Role.find_by(name: "user")
    @users = @team.users
    respond_to do |format|
      @result= NewRegistrationService.new({user: @user, team: @team, role: @role, check_user: @check_user}).check_limit?
       if @result
        flash[:success] = "User is successfully added to team!"
        format.js
      else
        flash[:danger] = "Maximum number of users exist or user already exist"
        format.js
      end

    end

  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path
    else
      @user.picture = nil
      render 'show'
    end
  end

  def view_edit_profile
    @user = User.find(params[:id])
  end

  def edit_profile
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path
    else
      render 'view_edit_profile'
    end
  end

  # def show_change_password
  #   @user=User.find(params[:id])
  # end

  # def custom_change_password
  #   @user = User.find(params[:id])
  #   if @user.update(password_params)
  #     sign_in(@user, :bypass => true)
  #     redirect_to user_path(@user)
  #   else
  #     render 'show_change_password'
  #   end
  # end



#   def emailcheck
#   @user = User.find(params[:email])
#   if @user.present?
#     render :json =>  ["user_email", false , "This User is already taken"]
#   else
#     render :json =>  ["user_email", true , ""]
#   end
# end


private
    def user_params
      params.require(:user).permit(:first_name, :email, :password,
                                   :password_confirmation,:picture,:last_name,:phone_number,:dob)
    end
    def role_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,:picture)
    end
    def team_params
      params.require(:team).permit(:name, :image, :max_no_users)
    end

    def password_params
       params.require(:user).permit(:password, :password_confirmation)
    end
    # def sign_up_params
    #   params.require(:user).permit(:first_name, :email, :password,
    #                                :password_confirmation,:picture,:last_name,:phone_number,:dob)
    # end

end
