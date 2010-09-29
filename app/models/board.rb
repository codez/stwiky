class Board < ActiveRecord::Base
  
  belongs_to :user
  has_many :notes
  
  validates :name, :presence => true, :uniqueness => {:scope => :user_id}
  validates :user, :presence => true
  
end