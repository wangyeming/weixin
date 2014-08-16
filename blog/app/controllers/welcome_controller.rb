class WelcomeController < ApplicationController
  skip_before_action :authorize, only: [:index, :show]
  def index
    @user = User.new
    if logged_in?
      redirect_to articles_url
    end
  end
end
