class ApiController < ApplicationController

    #Renders all posts as json.  Need to include the comments wired up via has_many
    def posts
        posts = Post.all.to_json( :include => [:comments] )
        render :json => posts 
    end

    #Renders serach results as json.
    def search
        posts = Post.where('title LIKE :search OR body LIKE :search', search: "%#{params[:search]}%")
        posts = posts.to_json( :include => [:comments] )
        render :json => posts 
    end

    #Creates a post
    def create_post
        title = params[:title]
        body = params[:body]

        post = Post.new(title: title, body:body)
        
        #Checks to see if the required fields exist
        if post.valid?
            post.save
            render :json => {success: true, post: post}
        else
            render :json => {success: false, errors: post.errors.messages}
        end

    end

    #Renders a single post with comments as json.  Checks to see if post exists. If not, return error.
    def show_post
        post_id = params[:post_id]

        if(Post.exists?(post_id))
            post = Post.find(post_id)
          
            render :json => {success: true, post: post, comments: post.comments}
        else
            render :json => {success: false}
        end
    end

    #Delete a post.  The destory method allows for cascading deletes of comments for the post
    def delete_post
        post_id = params[:post_id]

        post = Post.find(post_id)

        post.destroy
        render :json => {success: true}
    end

    #Creates a comment
    def create_comment
        comment = params[:comment]
        post_id = params[:post_id]

        comment = Comment.new(comment: comment, post_id: post_id)
        
        #Checks to see if a comment has the required fields met. If so, return all comments for the post. If not, return error.
        if comment.valid?
            comment.save
            render :json => {success: true, comments: Comment.where(post_id: post_id)}
        else
            render :json => {success: false, errors: comment.errors.messages}
        end

    end

    #Updates a comment
    def update_comment
        updated_comment = params[:comment]
        comment_id = params[:comment_id]
        post_id = params[:post_id]

        comment = Comment.find(comment_id)
        comment.comment = updated_comment 
        
        #Checks to see if a comment has the required fields met. If so, return all comments for the post. If not, return error.
        if comment.valid?
            comment.save
            render :json => {success: true, comments: Comment.where(post_id: post_id)}
        else
            render :json => {success: false, errors: comment.errors.messages}
        end

    end

    #Deletes a comment and returns the remaining posts comments
    def delete_comment
        comment_id = params[:comment_id]
        post_id = params[:post_id]

        Comment.delete(comment_id)
        render :json => {success: true, comments: Comment.where(post_id: post_id)}
    end
end


