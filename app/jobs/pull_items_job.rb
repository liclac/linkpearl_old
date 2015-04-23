class PullItemsJob < ActiveJob::Base
  queue_as :default
  
  include LodestoneLoadable

  def perform()
    page = 0
    loop do
      page += 1
      doc = lodestone_load page
      imported = import_items doc
      break if imported == 0
    end
  end
  
  def import_items(doc)
    imported = 0
    doc.css('.ic_link_txt').each do |box|
      link = box.css('> a').first
      lodestone_id = link.attr('href').split('/').last
      item = DBItem.find_or_initialize_by lodestone_id: lodestone_id
      
      # Break if we already have this item - this is way too much data to
      # reimport all the time, especially on a schedule... (8000+ items)
      break unless item.new_record?
      
      # Create categories right here - not doing so creates a race condition
      # (We have 25 threads all working on pulling items, conflicts happen...)
      breadcrumbs = box.css('.small a')
      link1 = breadcrumbs[-2]
      link2 = breadcrumbs[-1]
      query = Rack::Utils.parse_query URI(link2.attr('href')).query
      
      cat1 = DBItemCategory.find_or_create_by! lodestone_id: query['category2'] do |c|
        c.name = link1.text.strip
      end
      cat2 = DBItemCategory.find_or_create_by! lodestone_id: [query['category2'], query['category3']].join('.') do |c|
        c.name = link2.text.strip
        c.parent = cat1
      end
      
      # Finally, pull the item name and queue up a scrape job
      item.name = link.text.strip
      item.save
      
      LodestoneUpdateJob.perform_later(item)
      imported += 1
    end
    
    imported
  end
  
  def lodestone_link(page=1)
    "http://na.finalfantasyxiv.com/lodestone/playguide/db/item/?page=#{page}"
  end
end
