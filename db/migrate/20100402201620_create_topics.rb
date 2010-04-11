class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string      :title
      t.integer     :user_id
      t.integer     :views, :default => 0
      t.integer     :first_post_id
      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
