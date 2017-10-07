class TasksController < ApplicationController

  def new
    @task = Task.new
    @team = Team.find(params[:id])
    @tasks = @team.tasks
    @users = @team.users.where.not(id: current_user.id)
   end

  def create
    @task = Task.new(task_params)
    @task.team_id = params[:id]
    @team = Team.find(params[:id])
    @tasks = @team.tasks
    respond_to do |format|
      if @task.save
        flash[:success] = "Task assigned successfully"
        format.js
      else
        format.js
      end
    end
  end

  def task_action
    @task = Task.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def task_complete
    @task = Task.find(params[:id])
    if @task.update_attributes(status: "completed")
        redirect_to add_to_team_team_path(@task.team_id)
      else
        redirect_to root_path
      end
    else

  end

  def task_start
    @task = Task.find(params[:id])
    #@task.status = "started"
    if @task.update_attributes(status: "started")
        redirect_to add_to_team_team_path(@task.team_id)
      else
        redirect_to root_path
      end
  end

  def destroy
    @task = Task.find(params[:id])
    @team = Team.find(params[:team_id])
      if @task.destroy
        @tasks = @team.tasks
        respond_to do |format|
        flash[:success] = "Task deleted"
        format.js
      end
    end
  end


  private

  def task_params
    params.require(:task).permit(:name, :duration, :status, :user_id, :team_id)
  end


end
