namespace :db do
  desc "Generate mock articles data"
  task generate_mock_articles: :environment do
    # Clear existing data
    Article.delete_all
    ActsAsTaggableOn::Tagging.delete_all    

    # Create mock articles with associated tags
    CATEGORIES.each do |category|
      10.times do
        article = Article.create(
          title: Faker::Lorem.sentence,
          summary: Faker::Lorem.sentence(word_count: rand(20..40)),
          content: generate_long_paragraphs(rand(5..10)),
          price: rand(1.0..100.0).round(2),
          currency: "USD"
        )
        
        # One article has multiple tags
        # tags = CATEGORIES.map { |category| ActsAsTaggableOn::Tag.create(name: category[:name]) }
        # random_tags = tags.select { |tag| tag.name != category[:name] }.sample(rand(1..3))
        # article.tag_list.add(random_tags.pluck(:name))

        # One article has one tag
        article.tag_list.add(category[:name])
        article.save
      end
    end
  end

  def generate_long_paragraphs(paragraph_count)
    paragraphs = []
    paragraph_count.times do
      paragraphs << Faker::Lorem.paragraph(sentence_count: rand(2..20))
    end
    paragraphs.join("\n\n")
  end
end
