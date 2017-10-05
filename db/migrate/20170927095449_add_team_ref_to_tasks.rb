class AddTeamRefToTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :team, foreign_key: true
  end
end
