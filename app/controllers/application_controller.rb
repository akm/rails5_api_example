class ApplicationController < ActionController::API

  before_action :check_header

  private def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end

  private def check_header
    if ['POST','PUT','PATCH'].include? request.method
      if request.content_type !~ %r{application/vnd.api\+json}
        head :not_acceptable
      end
    end
  end

  def validate_type
    if params['data'] && params['data']['type']
      if params['data']['type'] == params[:controller]
        return true
      end
    end
    head :conflict
  end

  def validate_user
    token = request.headers["X-Api-Key"]
    head :forbidden and return unless token
    user = User.find_by token: token
    head :forbidden and return unless user
  end
end
