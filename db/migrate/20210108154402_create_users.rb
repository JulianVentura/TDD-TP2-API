require 'active_record'

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |table|
      table.string :name, null: false
      table.timestamps
    end
  end
end
