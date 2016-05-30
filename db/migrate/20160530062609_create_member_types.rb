class CreateMemberTypes < ActiveRecord::Migration
  def change
    create_table :member_types do |t|
      t.integer :group_id
      t.integer :user_id
      t.integer :type

      t.timestamps null: false
    end
  end
end
