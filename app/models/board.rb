class Board < ActiveRecord::Base
  
  belongs_to :user
  has_many :notes
  
  validates :name, :presence => true, :uniqueness => {:scope => :user_id}
  validates :shortname, :presence => true, :uniqueness => {:scope => :user_id}
  validates :user, :presence => true
  
  before_validation :set_shortname
  
  attr_accessible :name
  
  default_scope order('position')
  
  private
  
  def set_shortname
    self.shortname = name.downcase.gsub(/[^a-z0-9_\.\-]/, "")
  end
  
end