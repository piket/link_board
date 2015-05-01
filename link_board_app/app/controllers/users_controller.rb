class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        user_info = user_params
        user = User.find_or_initialize_by(email: user_info[:email])
        if user.new_record?
            user.password = user_info[:password]
            user.name = user_info[:name]
            if user.save
                flash[:success] = "You have been signed up ,please log in."
                redirect_to login_path
            else
                flash[:danger] = "You entered invalid information, pleasse try again"
                render :new
            end
        else
            flash[:danger] = "There is already a user with this email address."
            redirect_to login_path
        end
    end

    def index
        @posts = current_user.posts
        @vote = Vote.new
    end

    private

    def user_params
        params.require(:user).permit([:name,:email,:password])
    end

end