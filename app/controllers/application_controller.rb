class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    #App index that redriects to the posts
    def index
        redirect_to '/posts'
    end
end
