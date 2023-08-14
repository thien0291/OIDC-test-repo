module ApplicationHelper
  def article_categories
    [
      { name: 'Economy', uri: 'economy' },
      { name: 'Politics & Laws', uri: 'politics-and-laws' },
      { name: 'Society', uri: 'society' },
      { name: 'Sports', uri: 'sports' },
      { name: 'Tech', uri: 'tech' },
      { name: 'Health', uri: 'health' }
    ]
  end
end
