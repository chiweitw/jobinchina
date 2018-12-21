class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :name
      t.float :salary
      t.string :location
      t.string :url
      t.string :company
      t.references :search, foreign_key: true

      t.timestamps
    end
  end
end
