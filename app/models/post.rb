class Post < ApplicationRecord
	#This sets comments as children of post and deletes comments when post is destoryed
	has_many :comments, :dependent => :destroy
	
	#title and body are required
	validates :title, :presence => {:message => "A title is required"}
	validates :body, :presence => {:message => "A post body is required"}
end
