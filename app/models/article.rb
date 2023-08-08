class Article < ApplicationRecord
  has_rich_text :content

  has_many :transactions, as: :related_object
end
