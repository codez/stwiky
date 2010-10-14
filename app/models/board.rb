class Board < ActiveRecord::Base
  
  acts_as_list :scope => :user_id
  
  belongs_to :user
  has_many :notes, :dependent => :destroy
  
  validates :name, :presence => true, :uniqueness => {:scope => :user_id}
  validates :shortname, :presence => true, :uniqueness => {:scope => :user_id}
  validates :user, :presence => true
  
  before_validation :set_shortname
  
  attr_accessible :name
  
  
  private
  
  def set_shortname
    self.shortname = name.downcase.gsub(/[^a-z0-9_\-]/, "")
  end
  
end