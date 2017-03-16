class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations, unsigned: true, options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.string :email, null: false, charset: 'ascii', collation: 'ascii_bin'
      t.string :token, limit: 50, null: false, charset: 'ascii', collation: 'ascii_bin'
      t.datetime :expires_at, null: false
      t.datetime :sent_at, null: false
      t.timestamps
    end

    add_index :invitations, :email, name: 'idx_email', unique: true
    add_index :invitations, :token, name: 'idx_token', unique: true
  end
end
