class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_has_admin_rights, only: [:toggle_frozen]

  # GET /users
  # GET /users.json
  def index
    @users = User.includes(:beers, :ratings).all
    @active_users = User.active
    @frozen_users = User.inactive
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if user_params[:username].nil? and @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end

    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy if current_user == @user
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_frozen
    user = User.find(params[:id])
    user.update_attribute :is_frozen, (not user.is_frozen)
    new_status = user.is_frozen? ? "frozen" : "melted"
    redirect_to :back, notice: "user account #{new_status}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :active)
    end
end
