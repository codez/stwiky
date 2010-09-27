class Note < ActiveRecord::Base
  
  belongs_to :user
  
  validates :content, :presence => true
  validates :pos_x, :presence => true
  validates :pos_y, :presence => true
  validates :width, :presence => true
  
end
