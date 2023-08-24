namespace :db do
  desc "Generate real articles data"
  task generate_real_articles: :environment do
    # Clear existing data
    Article.delete_all
    ActsAsTaggableOn::Tagging.delete_all    
    
    categories = [
      { name: 'Economy' },
      { name: 'Politics and Laws' },
      { name: 'Society' },
      { name: 'Sports' },
      { name: 'Tech' },
      { name: 'Health' }
    ]

    articles_data = {
      'Economy' => [
        {
          title: "Global Markets React to Unexpected Trade Agreement",
          summary: "The international financial landscape experienced a seismic shift as key players finalized an unexpected trade agreement. Economists and experts weigh in on the potential impact on industries, stock markets, and global economic stability."
        },
        {
          title: "Inflation Concerns Spark Central Bank Action",
          summary: "Rising consumer prices have spurred central banks around the world to take action. As governments grapple with the challenge of balancing economic growth and price stability, citizens and businesses brace for potential changes in interest rates and financial policies."
        },
        {
          title: "Trade War Escalation and Global Trade Implications",
          summary: "Escalating trade tensions between major economies are raising concerns about the future of global trade. Experts analyze the potential consequences for supply chains, consumer prices, and economic growth."
        },
        {
          title: "Sustainable Investments and ESG Criteria Analysis",
          summary: "Investors are increasingly considering Environmental, Social, and Governance (ESG) criteria in their decision-making. Learn about the factors driving sustainable investments and their impact on industries."
        }
      ],
      'Politics and Laws' => [
        {
          title: "Policy Changes and Legislative Landscape Shift",
          summary: "Recent policy changes have sparked discussions about their impact on the legislative landscape. Experts analyze the implications for citizens, governments, and society at large."
        },
        {
          title: "Election Season: Key Issues and Voter Engagement",
          summary: "As election season approaches, candidates address pressing issues and work to engage voters. Explore the campaigns, debates, and voter outreach strategies shaping the political landscape."
        },
        {
          title: "Judicial Reforms: Enhancing Access to Justice",
          summary: "Efforts to reform the judicial system aim to improve access to justice and streamline legal processes. Learn about initiatives aimed at ensuring fair trials, reducing backlogs, and enhancing court efficiency."
        },
        {
          title: "International Agreements and Diplomatic Landscape",
          summary: "Diplomatic negotiations lead to international agreements that shape diplomatic relations and cooperation. Experts discuss the challenges and opportunities presented by these agreements."
        }
      ],
      'Society' => [
        {
          title: "Social Trends: Embracing Diversity and Inclusion",
          summary: "Changing social attitudes are driving discussions about diversity and inclusion across various sectors. Learn how organizations and communities are working to create more inclusive environments."
        },
        {
          title: "Digital Divide and Access to Technology",
          summary: "The digital divide persists as a significant challenge, impacting education, employment, and social participation. Explore efforts to bridge the gap and provide equitable access to technology."
        },
        {
          title: "Community Initiatives for Urban Challenges",
          summary: "Community-led initiatives are addressing urban challenges ranging from homelessness to environmental sustainability. Discover how local organizations are driving change and building resilient communities."
        },
        {
          title: "Generational Shift and Changing Consumer Preferences",
          summary: "Consumer preferences are evolving with generational shifts, influencing industries like retail, entertainment, and travel. Experts analyze the changing landscape and its implications for businesses."
        }
      ],
      'Sports' => [
        {
          title: "Championship Victory and Historic Win",
          summary: "Fans and players alike celebrate as a sports team secures a historic championship victory. Explore the journey to success and the impact on the team's legacy."
        },
        {
          title: "Olympic Dreams and Global Stage",
          summary: "Athletes from around the world gear up for the Olympic Games, showcasing dedication, talent, and sportsmanship. Learn about the stories behind the athletes and their pursuit of excellence."
        },
        {
          title: "Esports Rise and Competitive Scene",
          summary: "Esports is experiencing rapid growth as a global entertainment phenomenon. Discover the competitive scene, the business of esports, and the challenges of building a sustainable ecosystem."
        },
        {
          title: "Sports Technology and Performance Advancements",
          summary: "Advancements in sports technology are enhancing training, performance analysis, and injury prevention. Explore how athletes and teams are leveraging technology to gain a competitive edge."
        }
      ],
      'Tech' => [
        {
          title: "AI Advances and Industry Transformation",
          summary: "Artificial Intelligence (AI) breakthroughs are reshaping sectors like healthcare, finance, and manufacturing. Explore how AI is driving innovation and efficiency across various industries."
        },
        {
          title: "Cybersecurity Challenges and Digital Assets",
          summary: "As digital threats evolve, cybersecurity remains a top concern for individuals, businesses, and governments. Experts discuss the latest trends, strategies, and challenges in cybersecurity."
        },
        {
          title: "Digital Transformation and Business Models",
          summary: "Digital transformation is changing how businesses operate, from customer engagement to supply chain management. Learn about successful digital transformation strategies and their impact on industries."
        },
        {
          title: "Ethical AI and Societal Implications",
          summary: "The development and deployment of AI raise ethical concerns and questions about bias, transparency, and accountability. Explore the ethical dimensions of AI and the efforts to ensure responsible AI use."
        }
      ],
      'Health' => [
        {
          title: "Health Guidelines and Mental Well-being",
          summary: "Health organizations release new guidelines emphasizing the importance of mental well-being. Learn about strategies for maintaining mental health and building resilience."
        },
        {
          title: "Pandemic Preparedness and Global Health Crises",
          summary: "The COVID-19 pandemic has highlighted the need for robust pandemic preparedness and response plans. Experts discuss the lessons learned and the steps taken to enhance global health security."
        },
        {
          title: "Medical Breakthroughs and Research Advancements",
          summary: "Scientific breakthroughs are leading to new treatments, therapies, and medical discoveries. Explore recent advancements in medical research and their potential to improve patient outcomes."
        },
        {
          title: "Holistic Health and Integrative Medicine",
          summary: "The integration of traditional and modern medicine is gaining attention as a comprehensive approach to healthcare. Learn about practices that combine age-old wisdom with modern medical techniques."
        }
      ]
    }

    categories.each do |category|
      category_name = category[:name]
      category_articles = articles_data[category_name]

      category_articles.each do |article_data|
        article = Article.create(
          title: article_data[:title],
          summary: article_data[:summary],
          content: generate_long_paragraphs(rand(5..10)),
          price: rand(1.0..100.0).round(2),
          currency: 'USD'
        )

        article.category_list.add(category[:name])
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
