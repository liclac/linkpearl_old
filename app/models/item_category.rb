class ItemCategory < ActiveRecord::Base
  belongs_to :parent, class_name: 'ItemCategory'
  has_many :subcategories, class_name: 'ItemCategory', foreign_key: 'parent_id'
  has_many :items, class_name: 'Item', foreign_key: 'category_id'
end
