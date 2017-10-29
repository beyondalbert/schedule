class AddAssignToNameToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :assign_to_name, :string
  end
end
