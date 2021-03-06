class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :content
      t.datetime :start
      t.datetime :end
      t.integer :user_id
      t.boolean :public
      # 0:未结束；1:已结束
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
