class PostsController < ApplicationController
  
  #Route to place the Posts Vue component
  def index
    render "index"
  end

  #Route to place the Create Vue component
  def new
    render "new"
  end

  #Route to place the Create Vue component
  def show
    @post_id = params[:post_id]
    render "show"
  end

end
