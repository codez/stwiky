class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.text :content, :null => false
      t.integer :user_id, :null => false
      t.integer :pos_x, :null => false
      t.integer :pos_y, :null => false
      t.integer :width, :null => false

      t.timestamps
    end
    
    create_table :users do |t|
      t.string :name, :null => false
      t.string :password      
    end
  end

  def self.down
    drop_table :users
    drop_table :notes
  end
end
