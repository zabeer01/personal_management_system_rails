class CreateLandingPages < ActiveRecord::Migration[7.1]
  def change
    create_table :landing_pages do |t|
      t.string :title

      t.timestamps
    end
  end
end
