class AddJobQtyToDashboard < ActiveRecord::Migration[5.2]
  def change
    add_column :dashboards, :job_qty, :integer
  end
end
