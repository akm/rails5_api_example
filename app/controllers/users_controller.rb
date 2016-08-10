class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :validate_type, only: [:create, :update]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # Use callbacks to share common setup or constraints between actions.
  private def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    user = User.new
    user.errors.add(:id, "Wrong ID provided")
    render_error(user, :not_found)
  end

  private def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
