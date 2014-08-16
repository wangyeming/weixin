class ArticlesController < ApplicationController

  #http_basic_authenticate_with name: "christy", password: "greygray", except: [:index, :show]
  skip_before_action :authorize, only: [:index, :show]
  before_action :string_to_markdown
  def string_to_markdown
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end

  def new
    @article = Article.new
  end

  def create
    @user = User.find(session[:user_id])
    @article = @user.articles.create(article_params)

    #@article = Article.find(params[:article_id])
    #@commnet = @article.comments.create(comment_params)

  	#@article = Article.new(article_params)
    @article.markdown_text = @markdown.render(@article.text)
  	if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.user_id != session[:user_id]
      redirect_to articles_path, alert: "你无权删除其他用户的博客内容哟"
    else
      @article.destroy
      redirect_to articles_path
    end

  end



  def show
  	@article = Article.find(params[:id])
    @article_user = @article.user
    @user_all_articles = Article.where user_id: @article.user_id
    unless @article.markdown_text
      @article.markdown_text = @markdown.render(@article.text)
    end
    #@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end


  def index
  	@articles = Article.all
  end


  def edit
    @article = Article.find(params[:id])
    if @article.user_id != session[:user_id]
      redirect_to articles_path, alert: "你无权修改其他用户的博客内容哟"
    end
    @article.markdown_text = @markdown.render(@article.text)
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  private
  	def article_params
  		params.require(:article).permit(:title, :text)
  	end


end
