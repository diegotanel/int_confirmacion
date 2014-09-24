class SessionsController < ApplicationController

	def new
	end

	def destroy
		sign_out
		redirect_to root_url
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.password == params[:session][:password]
			sign_in user
      		redirect_to user
		else
			flash.now[:error] = "Email/Contrasena Invalida"
			render 'new'
		end
	end
end
