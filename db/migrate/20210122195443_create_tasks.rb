class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |table|
      table.string :title, null: false

      table.timestamps
    end
    add_reference :tasks, :user, foreign_key: true
  end
end
