class AddApprovedToUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base
    attr_accessible :approved
  end
  
  def up

    add_column :users, :approved, :boolean
    User.reset_column_information
    User.update_all approved: true
    
  end
  
  def down
    remove_column :users, :approved
  end
end
