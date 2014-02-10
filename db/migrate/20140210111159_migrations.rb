class Migrations < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :twitter_user
      t.string :content
      t.timestamps
    end

    create_table :twitter_users do |t|
      t.string :username
      t.timestamps
    end

    add_index :tweets, :twitter_user_id

  end
end
