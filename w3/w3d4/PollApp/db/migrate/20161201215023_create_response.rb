class CreateResponse < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :answer_id, null: false
      t.integer :responder_id, null: false
      t.timestamps
    end
    add_index :responses, :answer_id
    add_index :responses, :responder_id
  end
end
