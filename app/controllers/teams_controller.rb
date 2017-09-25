class TeamsController < ApplicationController

  def new
    @team=Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    if current_user.admin?
      @teams=Team.all
    else
      @teams=current_user.teams
    end
  end

  def destroy
    Team.find(params[:id]).destroy
    redirect_to root_path
  end

  def destroy_user
    @team= Team.find(params[:id])
    @user= User.find(params[:user_id])
    @team.users.delete(@user)
    if current_user.admin?
      redirect_to addtoteam_path
    else
      redirect_to root_path
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(team_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def add_to_team
    @team= Team.find(params[:id])
    @users=@team.users.where.not(id: current_user.id)
  end

  def user_select
    @team=Team.find(params[:id])
  end

 private

  def team_params
    params.require(:team).permit(:name,:image,:max_no_users)
  end

  def user_team
    params.require(:team_user).permit(:team_id,:user_id)
  end

end
