class SessionsController < ApplicationController


  def new

  end

  def create
    #haetaan käyttäjä tietokannasta, jos löytyy niin ohjataan
    #omalle sivulleen
    user = User.find_by username:params[:username]
    session[:user_id] = user.id if not user.nil?
    redirect_to :root
  end

  def destroy
    #yksinkertaisesti nollataan sessio (uloskirjautuminen) ja ohjataan etusivulle(?)
    session[:user_id] = nil
    redirect_to :root
  end

end