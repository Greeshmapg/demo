class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :image
      t.integer :max_no_users

      t.timestamps
    end
  end
end
