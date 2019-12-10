class PostsController < ApplicationController
  def index
    render "index"
  end

  def new
    render "new"
  end

  def create
    # Add a new `Post` to the database
  end

  def destroy
    # Remove a `Post` from the database
  end
end
