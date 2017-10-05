class NewRegistrationService

  def initialize(params)
    @user = params[:user]
    @team = params[:team]
    @role = params[:role]
    @check_user = params[:check_user]
   end

  def save_to_team
    if @team.users << @check_user
      UserMailer.invite_user(@check_user).deliver
      return true
    else
      return false
    end
  end

  def check_limit?
    if @team.users.count < @team.max_no_users
      if check_user_presence?
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def check_user_presence?
    if @check_user.present?
      check_presence_in_group
    else
      if save_user
        return true
      else
        return false
      end
    end
  end

  def check_presence_in_group
    if !@team.users.find_by(id: @check_user.id).present?
      if save_to_team
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def save_user
    @user.role_id=@role.id
    password = @user.password
    if @user.save
      @team.users << @user
      UserMailer.user_activation(@user,password).deliver
      return true
    else
      return false
    end
  end



end
