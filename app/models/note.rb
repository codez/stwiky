class Note < ActiveRecord::Base
  
  self.record_timestamps = false
  
  belongs_to :board
  has_one :user, :through => :board
  
  validates :content, :presence => true
  validates :pos_x, :presence => true
  validates :pos_y, :presence => true
  validates :width, :presence => true
  
  before_create :set_timestamps
  
  class << self
    def welcome_note
      Note.new(:content => File.read(File.join(Rails.root, 'doc', 'welcome.txt')),
               :pos_x => 100,
               :pos_y => 50,
               :width => 400,
               :height => 300)
    end
  end
  
  private
  
  def set_timestamps
    now = Time.now
    self.created_at = now
    self.updated_at = now
  end
  
end
