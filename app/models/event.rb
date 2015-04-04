class Event < ActiveRecord::Base
  belongs_to :group
  
  validates :name, presence: true
  validates :time, presence: true
end
