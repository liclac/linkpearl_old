class DBItem < ActiveRecord::Base
  belongs_to :category, class_name: 'DBItemCategory'
end
