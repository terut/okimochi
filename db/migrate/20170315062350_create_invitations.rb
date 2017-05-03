class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations, unsigned: true, options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.string :email, null: false, charset: 'ascii', collation: 'ascii_bin'
      t.datetime :sent_at, null: false
      t.timestamps
    end

    add_index :invitations, :email, name: 'idx_email', unique: true
  end
end
