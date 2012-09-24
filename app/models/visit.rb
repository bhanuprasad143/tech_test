class Visit < ActiveRecord::Base
  belongs_to :user
  attr_accessible :country
end
