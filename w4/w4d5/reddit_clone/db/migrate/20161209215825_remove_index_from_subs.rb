class RemoveIndexFromSubs < ActiveRecord::Migration
  def change
    remove_index :subs, :user_id
  end
end
