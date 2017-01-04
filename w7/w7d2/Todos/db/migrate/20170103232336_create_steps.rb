class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :title
      t.string :body
      t.integer :todo_id
      t.boolean :done

      t.timestamps null: false
    end
  end
end
