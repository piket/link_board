class VotesController < ApplicationController

    before_action :is_authenticated?

    def create
        if params.key? :user_id
            id = params[:user_id]
            thing = User.find(id)
        elsif params.key? :comment_id
            id = params[:comment_id]
            thing = Comment.find(id)
        elsif params.key? :post_id
            id = params[:post_id]
            thing = Post.find(id)
        else
            flash[:warning] = "Invalid vote"
            redirect_to root_path
            return
        end

        my_vote = thing.votes.find_by_user_id(current_user.id)

        if my_vote.nil?
            current_user.ratings << thing.votes.create(vote_params)
            dir = params[:vote][:value]
        else
            if params[:vote][:value].to_i != my_vote.value
                my_vote.value = params[:vote][:value]
                my_vote.save
                dir = params[:vote][:value]
            else
                my_vote.destroy
                dir = 0
            end
        end

        respond_to do |format|
            format.html { redirect_to :posts }
            format.json { render json: {id: id, votes:(thing.votes.reduce(0) {|sum,v| sum+v.value}), type: dir } }
        end
    end

    private

    def vote_params
        params.require(:vote).permit(:value)
    end

end