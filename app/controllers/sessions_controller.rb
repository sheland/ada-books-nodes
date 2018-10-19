class SessionsController < ApplicationController
  # def login
  #   author = Author.find_by(name: params[:author][:name])
  #
  #   if author.nil?
  #     # Create a new author
  #     author = Author.create(name: params[:author][:name])
  #   end
  #
  #   session[:user_id] = author.id
  #   flash[:success] = "#{author.name} Successfully logged in!"
  #   redirect_to root_path
  # end
  #
  # def new

  # end
  #
  # def destroy
  #   session[:user_id] = nil
  #   flash[:success] = 'Successfully logged out'
  #   redirect_back fallback_location: root_path
  # end

  def create
   auth_hash = request.env['omniauth.auth']
   user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if user
      # User was found in the database
      flash[:success] = "Logged in as returning user #{user.name}"
    else
      # User doesn't match anything in the DB
      # TODO: Attempt to create a new user
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"

    redirect_to root_path
  end
end
