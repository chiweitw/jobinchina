class AddUrlToJobSummary < ActiveRecord::Migration[5.2]
  def change
    add_column :job_summaries, :url, :text, default: [], array: true
  end
end
