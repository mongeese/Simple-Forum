class AddBoardToTopic < ActiveRecord::Migration
  def self.up
    add_column :topics, :board_id, :integer
  end

  def self.down
    drop_column :topics,:board_id
  end
end