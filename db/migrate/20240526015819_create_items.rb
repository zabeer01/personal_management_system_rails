class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :category
      t.text :details
      t.integer :user_id
      t.timestamps
    end
  end
end
