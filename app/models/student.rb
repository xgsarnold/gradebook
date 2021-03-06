class Student < ActiveRecord::Base
  has_secure_password
  belongs_to :teacher
  has_many :parents
  has_many :grades

  validates :teacher, presence: true
  validates :email, presence: true, uniqueness: true

end
