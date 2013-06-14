class AddLastActiveAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_active_at, :date
  end
end
