class AddKeywordToJobSummary < ActiveRecord::Migration[5.2]
  def change
    add_column :job_summaries, :keyword, :string
  end
end
