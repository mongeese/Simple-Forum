class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.string  :name
    end
  end

  def self.down
    drop_table :boards
  end
end
