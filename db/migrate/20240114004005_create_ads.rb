class CreateAds < ActiveRecord::Migration[7.1]
  def change
    create_table :ads do |t|
      t.string :name
      t.string :latin_name
      t.string :description
      t.string :place
      t.integer :price
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
