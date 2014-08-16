class AddMarkdownTextToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :markdown_text, :text
  end
end
