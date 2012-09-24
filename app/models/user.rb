class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :collects, :dependent => :destroy
  has_many :visits, :dependent => :destroy
 
  def collect?(currency)
    return Collect.where(:user_id => self.id, :currency => currency).first ? true : false
  end
  
  def collect_currencies
    collects.map(&:currency)
  end
  
  def visit?(country)
    return Visit.where(:user_id => self.id, :country => country).first ? true : false
  end
  
  def visited_countries
    visits.map(&:country)
  end
  
end
