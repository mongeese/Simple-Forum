class UserAasm < ActiveRecord::Migration
  def self.up
   add_column :users, :workflow_state, :string
  end

  def self.down
   remove_column :users, :workflow_state
  end
end
