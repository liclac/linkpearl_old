class Character < ActiveRecord::Base
  include LodestoneLoadable
  
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
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
  has_and_belongs_to_many :achievements
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  
  def lodestone_update(type=nil, **kwargs)
    if type == 'achievements'
      
      page = 0
      loop do
        page += 1
        doc = lodestone_load 'achievement', page, **kwargs
        imported = import_achievements doc
        break if imported == 0
      end
      
    else
      
      doc = lodestone_load
      
      extract_profile doc
      extract_classes doc
      
    end
    
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
  
  def import_achievements(doc)
    imported = 0
    
    doc.css('.achievement_list li .achievement_txt a').each do |link|
      lodestone_id = link.attr('href').split('/').last
      name = link.text
      
      ach = Achievement.find_or_initialize_by(lodestone_id: lodestone_id)
      if ach.new_record?
        ach.name = name
        ach.save
        
        # Queue up a job to check the detail page for later execution
        # (not when running tests; it'd slow everything to a crawl)
        LodestoneUpdateJob.perform_later(ach, self.lodestone_id) \
          unless Rails.env.test?
      elsif self.achievements.exists?(ach.id)
        break
      end
      
      self.achievements.push ach
      imported += 1
    end
    
    imported
  end
  
  def lodestone_link(subpage=nil, page=nil)
    url = "http://na.finalfantasyxiv.com/lodestone/character/#{lodestone_id}/"
    url += "#{subpage}/" if subpage
    url += "?page=#{page}" if page
    url
  end
  
  def to_param
    self.lodestone_id.to_s
  end
  
  def to_s
    "#{self.first_name} #{self.last_name} on #{self.world}"
  end
  
  def as_indexed_json(options={})
    as_json(
      only: [:first_name, :last_name, :world, :bio],
      methods: [:name],
    )
  end
  
  # ElasticSearch Configuration
  settings index: { number_of_shards: 1 }
end
