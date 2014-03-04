class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :heart_rate, default: 60

      t.timestamps
    end
  end
end