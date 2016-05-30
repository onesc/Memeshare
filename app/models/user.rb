class User < ActiveRecord::Base
  has_secure_password

  has_many :comments
  has_many :images
  has_and_belongs_to_many :groups
  has_many :ratings

end
