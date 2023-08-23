module ApplicationHelper
  def all_categories
    ActsAsTaggableOn::Tag.for_context(:categories).map(&:name)
  end
end
