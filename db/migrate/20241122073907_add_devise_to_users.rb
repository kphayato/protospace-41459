class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def change
    # 'email'カラムが存在しない場合にのみ追加する
    unless column_exists?(:users, :email)
      add_column :users, :email, :string, null: false, default: ""
    end

    # 'encrypted_password'カラムが存在しない場合にのみ追加する
    unless column_exists?(:users, :encrypted_password)
      add_column :users, :encrypted_password, :string, null: false, default: ""
    end

    # 必要なカラムを追加
    unless column_exists?(:users, :reset_password_token)
      add_column :users, :reset_password_token, :string
    end

    unless column_exists?(:users, :reset_password_sent_at)
      add_column :users, :reset_password_sent_at, :datetime
    end

    unless column_exists?(:users, :remember_created_at)
      add_column :users, :remember_created_at, :datetime
    end

    # インデックスがすでに存在しない場合にのみ追加
    unless index_exists?(:users, :email)
      add_index :users, :email, unique: true
    end

    unless index_exists?(:users, :reset_password_token)
      add_index :users, :reset_password_token, unique: true
    end
  end
end