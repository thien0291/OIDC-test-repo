class Article < ApplicationRecord
  acts_as_taggable_on :tags
  acts_as_taggable_on :categories

  has_rich_text :content

  has_many :transactions, as: :related_object
end
