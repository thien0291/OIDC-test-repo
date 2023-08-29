class AddThumbnailAndAuthorToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :thumbnail, :string, default: "https://mdbcdn.b-cdn.net/img/new/standard/city/018.jpg"
    add_column :articles, :author, :string, default: "Louis Theroux"
  end
end
