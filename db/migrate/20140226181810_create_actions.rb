class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.belongs_to :user
      t.belongs_to :activity
      t.datetime :completed

      t.timestamps
    end
  end
end
