class Character < ActiveRecord::Base
  def lodestone_update
    headers = {
      'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/600.3.18 (KHTML, like Gecko) Version/8.0.3 Safari/600.3.18"
    }
    doc = Nokogiri::HTML(open(lodestone_link, headers)) do |config|
      config.nonet
    end
    
    self.first_name, self.last_name = doc.css('.player_name_txt h2 a').text.strip.split(' ', 2)
    self.world = doc.css('.player_name_txt h2 span').text.gsub(/[\(\)]/, '').strip
    self.bio = doc.css('.txt_selfintroduction').text.strip
  end
  
  def lodestone_link
    return "http://na.finalfantasyxiv.com/lodestone/character/#{lodestone_id}/"
  end
end
