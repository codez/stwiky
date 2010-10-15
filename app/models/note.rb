class Note < ActiveRecord::Base
  
  DEFAULTS = {:pos_x => 100, :pos_y => 20, :width => 300, :height => 200}
  
  self.record_timestamps = false
  
  belongs_to :board
  has_one :user, :through => :board
  
  validates :content, :presence => true
  validates :pos_x, :presence => true
  validates :pos_y, :presence => true
  validates :width, :presence => true
  
  before_validation :use_defaults_where_blank
  before_create :set_timestamps
  
  attr_protected :board_id
  
  class << self
    def welcome_note
      Note.new(:content => welcome_content,
               :pos_x => 100,
               :pos_y => 20,
               :width => 460,
               :height => 530)
    end
    
    def welcome_content
      File.read(File.join(Rails.root, 'README'))
    rescue
      "h1. Welcome to Stwiky!\n\nDouble click to create or edit notes."
    end
  end
  
  def pos_right
    pos_x + width + 50
  end
  
  def pos_bottom
    pos_y + height + 100
  end
    
  def use_defaults_where_blank
    DEFAULTS.each do |attr, value|
      self[attr] = value if self[attr].blank?
      self[attr] = 0 if self[attr] < 0
    end
  end
  
  private

  def set_timestamps
    now = Time.now
    self.created_at = now
    self.updated_at = now
  end
  
end
