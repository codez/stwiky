class User < ActiveRecord::Base
  
  SALT = "schtzngrbn"
  
  has_many :boards, :order => "position", :dependent => :destroy
  has_many :notes, :through => :boards
  
  validates :name, :presence => true, 
                   :uniqueness => true, 
                   :format => {:with => /^[A-Za-z0-9_\-]+$/, 
                               :message => "must not contain special characters"},
                   :exclusion => { :in => ['login', 'signup'] }
  validates :password, :confirmation => true
  validates :secret, :presence => true
  
  before_validation :generate_secret, :on => :create
  before_save :store_password
  after_create :add_default_board
  
  attr_protected :secret
  
  class << self
      def login(name, password)
         where('name = ? AND password = ?', name, encrypt(password)).first
      end
    
      def encrypt(text)
        if text.present?
          Digest::SHA1.hexdigest(SALT + text.to_s)
        else
          ""
        end
      end
  end
  
  def password=(value)
    @store_password = true
    write_attribute :password, value
  end
  
  def add_default_board
    board = self.boards.create :name => 'Main'
    board.notes << Note.welcome_note
  end
  
  private 
  
  def store_password
    if @store_password
      self.password = self.class.encrypt(self.password)
      @store_password = false
    end
    true
  end
  
  def generate_secret
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    secret = ""
    1.upto(128) { |i| secret << chars[rand(chars.size-1)] }
    self.secret = secret
  end
  
end