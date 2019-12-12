Rails.application.routes.draw do

    scope :/ do
        get "/"               => "application#index"
        get "/posts"          => "posts#index"
        get "/post/new"       => "posts#new"
        get "/post/:post_id"  => "posts#show"  
    end

    scope :api do
        get  "/post/all"               => "api#posts"
        post  "/post/search"           => "api#search"
        post "/post/create"            => "api#create_post"
        get  "/post/show/:post_id"     => "api#show_post"  
        delete "/post/delete/:post_id" => "api#delete_post" 
        post "/post/comment/create"    => "api#create_comment" 
        post "/post/comment/update/:comment_id" => "api#update_comment" 
        delete "/post/comment/delete/:post_id/:comment_id" => "api#delete_comment" 

    end
end