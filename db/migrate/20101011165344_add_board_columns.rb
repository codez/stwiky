class AddBoardColumns < ActiveRecord::Migration
  def self.up
    add_column :boards, :shortname, :string    
  end

  def self.down
    remove_column :boards, :shortname
  end
end
