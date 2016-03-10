class Teacher < ActiveRecord::Base
  has_secure_password
  has_many :students

  validates :password, presence: true
  validates :email, presence: true, uniqueness: true
end
