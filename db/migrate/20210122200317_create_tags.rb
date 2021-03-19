class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |table|
      table.string :tag_name, null: false

      table.timestamps
    end
  end
end
