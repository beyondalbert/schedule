class AddAssignToAndPlanIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :assign_to, :integer
    add_column :tasks, :plan_id, :integer
  end
end
