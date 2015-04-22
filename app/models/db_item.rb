class DBItem < ActiveRecord::Base
  belongs_to :category, class_name: 'DBItemCategory'
  
  include LodestoneLoadable
  
  def lodestone_update(**kwargs)
    doc = lodestone_load **kwargs
    extract_categories doc
    extract_general doc
    extract_stats doc
  end
  
  def extract_categories(doc)
    breadcrumbs = doc.css('#breadcrumb li > a')
    
    link1 = breadcrumbs[-2]
    link2 = breadcrumbs[-1]
    query = Rack::Utils.parse_query URI(link2.attr('href')).query
    
    cat1 = DBItemCategory.find_or_create_by! lodestone_id: query['category2'] do |c|
      c.name = link1.text.strip
    end
    cat2 = DBItemCategory.find_or_create_by! lodestone_id: query['category3'] do |c|
      c.name = link2.text.strip
      c.parent = cat1
      
      attr_names = doc.css('.parameter_name')
      c.attr1 = attr_names[0].text.strip if attr_names.length > 0
      c.attr2 = attr_names[1].text.strip if attr_names.length > 1
      c.attr3 = attr_names[2].text.strip if attr_names.length > 2
    end
    
    self.category = cat2
  end
  
  def extract_general(doc)
    self.name = doc.css('.item_name').first.text.strip
    self.description = doc.css('.eorzeadb_tooltip_mt5').first.try(:text).try(:strip)
    self.unique = !doc.css('.rare').first.try(:text).blank?
    self.untradable = !doc.css('.ex_bind').first.try(:text).blank?
    
    ilvl_e = doc.css('.eorzeadb_tooltip_pt3').first
    self.ilvl = ilvl_e.text.sub('Item Level ', '').strip.to_i if ilvl_e
    
    classes_e = doc.css('.class_ok').first
    self.classes = classes_e.text.strip if classes_e
    
    level_e = doc.css('.gear_level').first
    self.level = level_e.text.sub('Lv. ', '').strip.to_i if level_e
  end
  
  def extract_stats(doc)
    attrs = doc.css('.sys_nq_element .parameter')
    self.attr1 = attrs[0].text.strip.to_f if attrs.length > 0
    self.attr2 = attrs[1].text.strip.to_f if attrs.length > 1
    self.attr3 = attrs[2].text.strip.to_f if attrs.length > 2
    
    new_stats = []
    doc.css('.sys_nq_element .basic_bonus li').each do |e|
      stat, bonus = e.text.strip.split ' +', 2
      new_stats.push [stat, bonus.to_i]
    end
    self.stats = new_stats
  end
  
  def lodestone_link
    "http://na.finalfantasyxiv.com/lodestone/playguide/db/item/#{lodestone_id}/"
  end
end
