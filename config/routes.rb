Rails.application.routes.draw do

    scope :/ do
        get "/"        => "posts#index"
        get "/new"     => "posts#new"
        get ":id" => "posts#show"  
    end

    scope :api do
        get "/posts"      => "api#posts"
        get "/create"     => "api#create"
        get "/edit/:id"   => "api#edit"  
        get "/delete/:id" => "api#delete"  
    end
end