class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles, id: :uuid do |t|
      t.string :title
      t.text :summary
      t.text :content
      t.decimal :price
      t.string :currency, default: "USD"

      t.timestamps
    end
  end
end
