class TeamsController < ApplicationController

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    authorize @team
    respond_to do |format|
      if @team.save
        flash[:success] = "New Team created!!!"
        format.js
      else
        format.js
      end
    end
  end

  def index
    @team = Team.new
    if current_user.admin?
      @teams = Team.all
    else
      @teams = current_user.teams
    end
  end

  def show_delete_modal
    @team = Team.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @team = Team.find(params[:id]).destroy
    @teams = Team.all
    respond_to do |format|
      format.js
    end
  end

  def destroy_user
    @team = Team.find(params[:id])
    @user = User.find(params[:user_id])
     respond_to do |format|
    @team.users.delete(@user)
    @users = @team.users
    @teams = @user.teams
    @user.tasks.destroy_all

      format.js
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.users.count >= @team.max_no_users.to_i
      if @team.update_attributes(team_params)
        redirect_to root_path
      else
        render 'edit'
      end
    else
      flash.now[:alert] = 'More users exist in team!!!Please delete some users'
      render 'edit'
    end
  end

  def add_to_team
    @team = Team.find(params[:id])
    @user = User.new
    @users = @team.users.where.not(id: current_user.id)
    @task = Task.new
    @tasks = @team.tasks
    @user_tasks = @tasks.where(user_id: current_user.id)
  end

  def user_select
    @team = Team.find(params[:id])
  end

 private

  def team_params
    params.require(:team).permit(:name,:image,:max_no_users)
  end

  def user_team
    params.require(:team_user).permit(:team_id,:user_id)
  end

end
