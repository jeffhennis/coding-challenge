class Comment < ApplicationRecord
	belongs_to :post
	
	#comment is required
	validates :comment, :presence => {:message => "A comment is required"}
end
