class PollItem < ActiveRecord::Base
  belongs_to :poll
  acts_as_list scope: :poll
  
  validates :poll, presence: true
  validates :text, presence: true
  
  def to_s
    "#{position}: #{text}"
  end
end
