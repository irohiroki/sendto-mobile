class AddUserLink < ActiveRecord::Migration
  def self.up
    add_column :users, :link, :string, :limit => 2048
    add_column :users, :title, :string, :limit => 2048
  end

  def self.down
    remove_column :users, :title
    remove_column :users, :link
  end
end
