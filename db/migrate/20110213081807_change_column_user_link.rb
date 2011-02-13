class ChangeColumnUserLink < ActiveRecord::Migration
  def self.up
    rename_column :users, :link, :escaped_link
  end

  def self.down
    rename_column :users, :escaped_link, :link
  end
end
