class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles, unsigned: true, options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.unsigned_bigint :user_id, null: false
      t.text :body, null: false
      t.date :published_on, null: false
      t.datetime :edited_at, null: false
      t.timestamps
    end

    add_index :articles, [:user_id, :published_on], name: 'idx_uid_and_published_on', unique: true
    add_index :articles, [:edited_at], name: 'idx_edited_at'
  end
end
