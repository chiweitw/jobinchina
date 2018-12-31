class CreateJobSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :job_summaries do |t|
      t.integer :qty
      t.float :average_salary
      t.text :location_qty, default: [], array: true
      t.text :location_salary, default: [], array: true
      t.references :search, foreign_key: true

      t.timestamps
    end
  end
end
