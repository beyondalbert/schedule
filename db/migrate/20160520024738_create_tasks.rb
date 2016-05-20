class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :content
      t.datetime :start
      t.datetime :end
      t.integer :user_id
      t.boolean :public

      t.timestamps null: false
    end
  end
end
