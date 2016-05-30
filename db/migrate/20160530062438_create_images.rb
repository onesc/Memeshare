class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :image
      t.text :caption
      t.integer :rating
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
