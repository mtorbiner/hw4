class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({email => params["email"]})
    #Look at the User database, choose the entry with matching email
    if @user
      #this equals if @user != nil, basically checks whether this user is on the database, namely, we are dealing with a registered user.
      if BCrypt::Password.new(@user["password"]) == params["password"]
        #we are using to encript the password. This syntax is weird but what we are doing is checking if the entered password, when encripted, matches our database. 
        #if it does, then validation is true and we proceed to grant access.
        session["user_id"] =  @user["id"]
        #we could use cookies, but it is not safe, so we use seesion to avoid problems.
        flash["notice"] = "Welcome!"
        redirect_to "/places"
      else
        redirect_to "sessions/new"
      end
    else
      redirect_to "sessions/new"
  end

  #If authentication fails, we just load the login screen again.

  def destroy
  end
end
  