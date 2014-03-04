class CreateActs < ActiveRecord::Migration
  def change
    create_table :acts do |t|
      t.belongs_to :user
      t.belongs_to :activity
      t.datetime :completed
      t.integer :minutes
      t.integer :calories
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end
    add_index :acts, :user_id      # fast lookup by person
    add_index :acts, :activity_id  # dashboard stats per activity
  end
end
