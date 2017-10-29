class AddStatusToPlans < ActiveRecord::Migration
  def change
    # 0: 未完成；1：已完成
    add_column :plans, :status, :integer, default: 0
  end
end
