class Achievement < ActiveRecord::Base
  validates :lodestone_id, presence: true
  has_and_belongs_to_many :character
end
