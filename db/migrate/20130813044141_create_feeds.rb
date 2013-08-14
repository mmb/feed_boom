class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.text :name, null: false, unique: true

      t.timestamps
    end

    add_index :feeds, :name, unique: true
  end
end
