class AdminController < ApplicationController
  def index
    @article = Article.all
  end
end
