class AddSkillsToSearch < ActiveRecord::Migration[5.2]
  def change
    add_column :searches, :skills, :text
  end
end
