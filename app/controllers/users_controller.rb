class UsersController < ApplicationController
    before_action :correct_user, only: [:edit]
	def index
		@books = Book.all
		# [<book1>, <book2>, ...]

		@book = Book.new

        # @user = User.new
        @user = current_user
        @users = User.all
        # [<user1>, <user2>, ...]
    end
	def show
		@user = User.find(params[:id])
		@book = Book.new
		@books = Book.all
	end
	def edit
		@user = User.find(params[:id])
	end
    def update
  	@user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_path(@user.id),notice:'Your account was successfully recreated.'
        else
            render :edit
        end
    end



	private
	def user_params
		params.require(:user).permit(:name, :email, :encrypted_password, :introduction, :profile_image)
	end
	def correct_user
		user = User.find(params[:id])
		if user != current_user
           redirect_to user_path(current_user)
        end
    end
end
