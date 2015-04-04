class Group < ActiveRecord::Base
  has_and_belongs_to_many :characters
  has_many :events, -> { order(:time) }
  
  validates :name, presence: true
end
