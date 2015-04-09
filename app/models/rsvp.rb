class RSVP < ActiveRecord::Base
  belongs_to :character
  belongs_to :event
  
  def to_s
    "#{self.answer} for #{self.date}"
  end
end
