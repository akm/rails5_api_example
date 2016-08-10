class SessionsController < ApplicationController
  def create
    data = ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    Rails.logger.error params.to_yaml
    user = User.where(name: data[:name]).first
    head :not_acceptable and return unless user
    if user.authenticate(data[:password])
      user.regenerate_token
      render json: user, status: :created, meta: default_meta,
             serializer: ActiveModel::Serializer::SessionSerializer and return
    end
    head :forbidden
  end

  def destroy
    user = User.where(token: params[:id]).first
    head :not_found and return unless user
    user.regenerate_token
    head :no_content
  end
end
