class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :duration
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
