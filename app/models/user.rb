class User < ActiveRecord::Base
  validates :email, uniqueness: true

	has_many :posts
  has_many :comments
  has_many :bookings
  
end
