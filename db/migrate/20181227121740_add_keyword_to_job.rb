class AddKeywordToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :keyword, :string, :default => ""
    #Ex:- :default =>''
  end
end
