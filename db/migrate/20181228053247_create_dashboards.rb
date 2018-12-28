class CreateDashboards < ActiveRecord::Migration[5.2]
  def change
    create_table :dashboards do |t|
      t.string :keyword
      t.float :average_salary, default: 0
      t.integer :searched_times, default: 0
      t.text :most_opportunities, default: [], array: true
      t.text :highest_paying, default: [], array: true
      t.text :hot_skills

      t.timestamps
    end
  end
end
