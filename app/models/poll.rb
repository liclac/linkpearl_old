class Poll < ActiveRecord::Base
  belongs_to :belongs_to, polymorphic: true
  has_many :poll_items, -> { order(position: :asc) }
  
  scope :open, -> { where("closes_at > ?", Time.now) }
  
  validates :title, presence: true
  validates :description, presence: true
  validates :closes_at, presence: true
  
  def to_s
    title
  end
end
