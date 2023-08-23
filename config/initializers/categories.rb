# # config_for is not working
# # CATEGORIES_CONFIG = Rails.application.config_for(:categories)
# CATEGORIES_CONFIG = YAML.load_file("config/categories.yml")

# CATEGORIES = CATEGORIES_CONFIG["page_categories"].map do |category|
#   {
#     name: category["name"],
#     id: category["id"],
#   }
# end

# CATEGORIES = ActsAsTaggableOn::Tag.for_context(:categories).map do |category_tag|
#   {
#     name: category_tag.name,
#     id: category_tag.name,
#   }
# end
