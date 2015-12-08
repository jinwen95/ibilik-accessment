class User < ActiveRecord::Base
  validates :email, uniqueness: true

	has_many :posts
end
