class CreateTagging < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :user_id, null: false
      t.string :topic, null: false
      t.timestamps
    end
  end
end
