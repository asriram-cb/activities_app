class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :calories, default: 0

      t.timestamps
    end
  end
end