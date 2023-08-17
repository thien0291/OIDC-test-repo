# config_for is not working
# CATEGORIES_CONFIG = Rails.application.config_for(:categories)
CATEGORIES_CONFIG = YAML.load_file("config/categories.yml")

CATEGORIES = CATEGORIES_CONFIG["page_categories"].map do |category|
    {
      name: category["name"],
      uri: category["uri"]
    }
  end
