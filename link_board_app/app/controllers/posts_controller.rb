class PostsController < ApplicationController

    before_action :is_authenticated?, except: [:index]

    def index
        @posts = Post.joins(:votes).group('posts.id').order('SUM(votes.value) DESC')
        @vote = Vote.new
        respond_to do |format|
            format.json { render json: @posts }
            format.xml { render xml: @posts }
            format.html
        end
    end

    def new
        @post = Post.new
    end

    def show
        @post = Post.find params[:id]
        @vote = Vote.new
        @comment = Comment.new
        @comment_ref = false
    end

    def create
        post = current_user.posts.create(post_params)
        puts "*"*10
        puts "The attempted post id: #{post.id.nil?}"
        puts "*"*10
        if post.id.nil?
            flash[:danger] = "You must enter a valid title and url"
            @post = Post.new
            render :new
        else
            flash[:success] = "You have created a new post"
            redirect_to posts_path
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        Post.update params[:id],post_params
    end

    def destroy
        Post.destroy params[:id]
    end

    private

    def post_params
        params.require(:post).permit(:title,:link)
    end

end