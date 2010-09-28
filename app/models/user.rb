class User < ActiveRecord::Base
  
  SALT = "schtzngrbn"
  
  has_many :notes
  
  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
  
  before_save :store_password
  
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
  
end