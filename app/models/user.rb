class User < ActiveRecord::Base
  
  SALT = "schtzngrbn"
  
  has_many :boards
  has_many :notes, :through => :boards
  
  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
  validates :secret, :uniqueness => true
  
  before_create :generate_secret
  before_save :store_password
  after_create :add_default_board
  
  class << self
      def login(name, password)
         where('name = ? AND password = ?', name, encrypt(password)).first
      end
    
      def encrypt(text)
        Digest::SHA1.hexdigest(SALT + text.to_s)
      end
  end
  
  def password=(value)
    @store_password = true
    write_attribute :password, value
  end
  
  private 
  
  def store_password
    if @store_password
      self.password = self.class.encrypt(password)
    end
  end
  
  def add_default_board
    board = self.boards.create :name => 'Main'
    board.notes << Note.welcome_note
  end
  
  def generate_secret
    # TODO
  end
  
end