class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :owner
      t.datetime :start
      t.datetime :end
      t.boolean :public

      t.timestamps null: false
    end
  end
end
