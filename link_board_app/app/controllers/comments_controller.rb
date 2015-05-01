class CommentsController < ApplicationController

    before_action :is_authenticated?, except: [:index, :show]

    def show
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:comment_id]).joins(:votes).group('comments.id').order('SUM(votes.value) DESC')
        @vote = Vote.new
    end

    def new
        @comment = Comment.new
        @post = Post.find(params[:post_id])
        if params.key? :comment_id
            @comment_ref = Comment.find(params[:comment_id])
        else
            @comment_ref = false
        end
    end

    def create
        post = Post.find(params[:post_id])
        if params.key? :comment_id
            current_user.comments << Comment.find(params[:comment_id]).comments.create(comment_params)
        else
            current_user.comments << post.comments.create(comment_params)
        end
        respond_to do |format|
            format.html {redirect_to post_path(post)}
            # format.json { render json: {}}
        end
    end

    def edit
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:id])
        if params.key? :comment_id
            @comment_ref = Comment.find(params[:comment_id])
        else
            @comment_ref = false
        end
    end

    def update
        Comment.update(params[:id],comment_params)
        redirect_to Post.find(params[:post_id])
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end

end