class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords do |t|
      t.string :name
      t.integer :searched_times, default: 0
      t.float :average_salary, default: 0
      t.text :hot_places, array: true, default: []
      t.text :skills, array: true, default: []

      t.timestamps
    end
  end
end
