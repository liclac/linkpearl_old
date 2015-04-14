require 'open-uri'

class Character < ActiveRecord::Base
  ABBREVIATIONS = {
    'GLA' => 'Gladiator', 'PGL' => 'Pugilist',
    'MRD' => 'Marauder', 'LNC' => 'Lancer',
    'ARC' => 'Archer', 'ROG' => 'Rogue',
    'CNJ' => 'Conjurer', 'THM' => 'Thaumaturge',
    'ACN' => 'Arcanist',
    
    'CRP' => 'Carpenter', 'BSM' => 'Blacksmith',
    'ARM' => 'Armorer', 'GSM' => 'Goldsmith',
    'LTW' => 'Leatherworker', 'WVR' => 'Weaver',
    'ALC' => 'Alchemist', 'CUL' => 'Culinarian',
    'MIN' => 'Miner', 'BTN' => 'Botanist',
    'FSH' => 'Fisher',
  }
  
  belongs_to :user
  has_and_belongs_to_many :groups
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  
  def lodestone_load(subpage=nil, page=0)
    headers = {
      'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/600.3.18 (KHTML, like Gecko) Version/8.0.3 Safari/600.3.18"
    }
    url = lodestone_link(subpage, page)
    
    Nokogiri::HTML(open(url, headers)) { |config| config.nonet }
  end
  
  def lodestone_update
    doc = lodestone_load
    
    extract_profile doc
    extract_classes doc
    
    # Allow 'Character.find(...).lodestone_update.save!'
    self
  end
  
  def extract_profile(doc)
    self.first_name, self.last_name = doc.css('.player_name_txt h2 a').text.strip.split(' ', 2)
    self.world = doc.css('.player_name_txt h2 span').text.gsub(/[\(\)]/, '').strip
    self.bio = doc.css('.txt_selfintroduction').text.strip
  end
  
  def extract_classes(doc)
    info_classes = {}
    
    nodes = doc.css('td.ic_class_wh24_box:not(:empty)')
    nodes.each do |name_node|
      level_node = name_node.next_element
      exp_node = level_node.next_element
      
      name = name_node.text
      level = level_node.text.to_i
      exp, exp_next = exp_node.text.split('/').map(&:to_i)
      
      info_classes[ABBREVIATIONS.key(name)] = {
        level: level, exp: exp, exp_next: exp_next
      }
    end
    
    self.info[:classes] = info_classes
  end
  
  def lodestone_link(subpage=nil, page=0)
    url = "http://na.finalfantasyxiv.com/lodestone/character/#{lodestone_id}/"
    url += "#{subpage}/" if subpage
    url += "?page=#{page}" if page
  end
  
  def to_param
    self.lodestone_id.to_s
  end
  
  def to_s
    "#{self.first_name} #{self.last_name} on #{self.world}"
  end
end
