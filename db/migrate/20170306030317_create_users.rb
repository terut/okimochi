class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :bigint, unsigned: true, options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.string :username, null: false, limit: 30, charset: 'ascii', collation: 'ascii_bin'
      t.string :email, null: false, charset: 'ascii', collation: 'ascii_bin'
      t.string :name, limit: 100
      t.text :bio
      t.string :magic_link_token, limit: 50
      t.datetime :magic_link_expires_at
      t.datetime :magic_link_sent_at
      t.timestamps
    end

    add_index :users, :username, name: 'idx_username', unique: true
    add_index :users, :email, name: 'idx_email', unique: true
    add_index :users, :magic_link_token, name: 'idx_magic_link_token', unique: true
  end
end
