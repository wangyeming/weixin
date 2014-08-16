class CommentsController < ApplicationController

  #http_basic_authenticate_with name: "christy", password: "greygray", only: [:destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    #@comment.user_id = current_user.user_id
    @comment.user = current_user
    if @comment.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  # def create
  #   @user = User.find(session[:user_id])
  #   @article = Article.find(params[:article_id])
  #   @comment = @user.articles.comments.create(comment_params)
  #   if @comment.save
  #     redirect_to article_path(@article)
  #   else
  #     render 'new'
  #   end
  # end


  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def index
    @comments = Comment.all
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
