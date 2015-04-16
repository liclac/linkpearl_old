require 'open-uri'

class Achievement < ActiveRecord::Base
  include LodestoneLoadable
  
  validates :lodestone_id, presence: true
  has_and_belongs_to_many :character
  
  # c_lid = Character Lodestone ID
  def lodestone_update(c_lid)
    doc = lodestone_load c_lid
    e = doc.css('.achievement_txt').first
    
    # THIS IS AWFUL
    self.description = e.css('.achievement_date').first.next.text.strip
  end
  
  def lodestone_link(c_lid)
    # For some reason, the Eorzea Database uses completely different IDs from
    # a character's achievement list, so we need to look at some character's
    # achievement list to be able to find it. Default is Yoshi-P's public alt.
    "http://na.finalfantasyxiv.com/lodestone/character/#{c_lid}/achievement/detail/#{self.lodestone_id}/"
  end
end
