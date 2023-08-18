class Article < ApplicationRecord
  acts_as_taggable_on :tags
  has_rich_text :content

  has_many :transactions, as: :related_object
end
