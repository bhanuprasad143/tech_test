class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :visits
 
  def visit?(country)
    return Visit.where(:user_id => self.id, :country => country).first ? true : false
  end
  
  def visited_countries
    visits.map(&:country)
  end
  
  def unvisited_countries
    visits.map(&:country)
  end
  
end
