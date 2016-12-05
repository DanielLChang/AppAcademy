class UpdateUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name
    remove_column :users, :email
    add_column :users, :username, :string, presence: true
    add_index :users, :username, unique: true
  end
end
