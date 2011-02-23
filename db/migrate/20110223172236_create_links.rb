class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.references :user
      t.string :uri,   :limit => 2048
      t.string :title, :limit => 2048

      t.timestamps
    end

    add_index :links, :user_id

    remove_column :users, :escaped_link
    remove_column :users, :title
  end

  def self.down
    add_column :users, :title,        :string, :limit => 2048
    add_column :users, :escaped_link, :string, :limit => 2048

    drop_table :links
  end
end
