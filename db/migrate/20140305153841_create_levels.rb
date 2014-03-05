class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :number
      t.integer :calorie_goal
      t.integer :activity_goal
      t.string :title
    end
  end
end
