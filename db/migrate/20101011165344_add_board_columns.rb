class AddBoardColumns < ActiveRecord::Migration
  def self.up
    add_column :boards, :shortname, :string
    remove_column :users, :logged_in
   
    Board.all.each &:save
  end

  def self.down
    remove_column :boards, :shortname
  end
end
