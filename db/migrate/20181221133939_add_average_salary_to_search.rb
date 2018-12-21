class AddAverageSalaryToSearch < ActiveRecord::Migration[5.2]
  def change
    add_column :searches, :average_salary, :float
  end
end
