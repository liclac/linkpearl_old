class DBItemCategory < ActiveRecord::Base
  belongs_to :parent, class_name: 'DBItemCategory'
  has_many :subcategories, class_name: 'DBItemCategory', foreign_key: 'parent_id'
  has_many :items, class_name: 'DBItem', foreign_key: 'category_id'
end
