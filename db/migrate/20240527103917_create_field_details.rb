class CreateFieldDetails < ActiveRecord::Migration[7.1]
   def change
    create_table :field_details do |t|
      t.belongs_to :item, null: false, foreign_key: true
      t.string :field_name
      t.string :field_val

      t.timestamps
    end
  end
end
