class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.text :content, :null => false
      t.integer :board_id, :null => false
      t.integer :pos_x, :null => false
      t.integer :pos_y, :null => false
      t.integer :width, :null => false
      t.integer :height
      t.integer :position

      t.timestamps
    end
    
    create_table :users do |t|
      t.string :name, :null => false
      t.string :password    
      t.string :email
      t.string :secret
    end
    
    create_table :boards do |t|
      t.string :name, :null => false
      t.integer :user_id, :null => false
      t.integer :position
    end
  end

  def self.down
    drop_table :notes
    drop_table :boards
    drop_table :users
  end
end
