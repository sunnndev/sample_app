class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: :destroy
  
	def show
		@user = User.find(params[:id])
	end

	def new
		if signed_in?
			redirect_to root_path
		else 
			@user = User.new
		end
	end

	def create
		if signed_in?
			redirect_to root_path
		else
		    @user = User.new(user_params)
		    if @user.save
		      # Handle a successful save.
		      	sign_in @user
		    	flash[:success] = "Welcome to the Sample App!"
		    	redirect_to @user
			else
		    	render 'new'
		    end
		end
	end

	def edit
		# @user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update_attributes(user_params)
			# Handle a successful update.
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_url
	end

	def index
		# @users = User.all
		@users = User.paginate(page: params[:page])
	end	

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		def signed_in_user
	      # redirect_to signin_url, notice: "Please sign in." unless signed_in?
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
