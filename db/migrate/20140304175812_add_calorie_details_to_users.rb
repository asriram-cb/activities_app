class AddCalorieDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :weight, :integer
    add_column :users, :gender, :string
  end
end
