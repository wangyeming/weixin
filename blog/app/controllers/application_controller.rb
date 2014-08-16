class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  before_action :authorize

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to root_url, notice: "Please log in"
    end
  end

  helper_method :current_user, :logged_in?, :current_user_articles_count, :current_user_comments_count

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
   current_user != nil
 end

  def current_user_articles_count
    @current_user_articles = Article.where user_id: session[:user_id]
    #@current_user_articles = Article.find_by(user_id: session[:user_id])
    if @current_user_articles
      @current_user_articles_count = @current_user_articles.length
    else
      @current_user_articles_count = 0
    end
  end

  def current_user_comments_count
    @current_user_comments = Comment.where user_id: session[:user_id]
    if @current_user_comments
      @current_user_comments_count = @current_user_comments.length
    else
      @current_user_comments_count = 0
    end
  end
end
