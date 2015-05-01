class SessionsController < ApplicationController

    # login (GET)
    def new
    end

    # set this session (POST)
    def create
        f_params = form_params
        @user = User.authenticate f_params[:name], f_params[:password]
        if @user
            session[:user_id] = @user.id
            flash[:success] = "Login Successful"
            redirect_to root_path
        else
            flash[:danger] = "Credentials Invalid"
            render :new
        end
    end

    # end session (DELETE typically)
    def destroy
        session[:user_id] = nil
        flash[:info] = "User has logged out"
        redirect_to root_path
    end

    private

    def form_params
        params.require(:user).permit(:name, :password)
    end

end