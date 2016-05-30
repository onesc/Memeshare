class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.text :name
      t.text :join_code

      t.timestamps null: false
    end
  end
end
