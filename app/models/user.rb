class User < ActiveRecord::Base
  has_many :characters
  has_many :groups, :through => :characters
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def to_s
    self.email
  end
end
