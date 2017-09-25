class UsersController < ApplicationController

  def custom_new
    @user=User.new
    @team=Team.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @role = Role.find(@user.role_id)
  end

  def custom_create
    @user_email = params[:user][:email]
    @user = User.find_by(email: @user_email)
    @team=Team.find(params[:id])

    if @team.users.count(@team.id) < @team.max_no_users
      if @user.present?
        if !@team.users.find_by(id: @user.id).present?
          if @team.users << @user
            flash[:success]="User is successfully added to team!"
            UserMailer.invite_user(@user).deliver
            redirect_to root_url
          else
            flash[:danger] = "Action failed."
          end
        else
          flash[:danger] = "User already exist!!!."
          redirect_to root_url
        end
      else
        @user = User.new(user_params)
        @role = Role.find_by(name:"user")
        @user.role_id=@role.id
        password = @user.password
        if @user.save
          @team.users << @user
          UserMailer.user_activation(@user,password).deliver
          flash[:success]="User is successfully added to team!"
          redirect_to root_url
        else
          render 'custom_new'
        end
      end
    else
      flash[:danger] = "Maximum number of users exist.Please delete some users to add new ones!!!"
      redirect_to root_url
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
      render 'show'
    end
  end

  def show_change_password
    @user=User.find(params[:id])
  end

  def custom_change_password
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render 'show_change_password'
    end
  end


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
    # def sign_up_params
    #   params.require(:user).permit(:first_name, :email, :password,
    #                                :password_confirmation,:picture,:last_name,:phone_number,:dob)
    # end

end
