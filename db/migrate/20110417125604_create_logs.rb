class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.string :uri,   :limit => 2048

      t.datetime :created_at
    end
  end

  def self.down
    drop_table :logs
  end
end
