class AddJoinableToGroups < ActiveRecord::Migration
  def change
  add_column :groups, :joinable, :boolean, :default => true
  end
end
