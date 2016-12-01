class CreateShortenedUrl < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :short_url, null: false
      t.string :long_url, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_index :urls, :short_url, :unique => true
    add_index :urls, :user_id
  end
end
