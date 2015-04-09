class Event < ActiveRecord::Base
  belongs_to :group
  has_many :rsvps
  
  validates :name, presence: true
  validates :time, presence: true
  
  def weekly_rsvps_for(character)
    existing = self.rsvps.where('character_id = ?', character.id).all
    days = {}
    
    existing.each { |rsvp| days[rsvp.date] = rsvp }
    today = Date.today
    7.times do |i|
      day = today + i.days
      days[day] = RSVP.new(character: character, date: day) unless days.key? day
    end
    
    days.sort
  end
end
