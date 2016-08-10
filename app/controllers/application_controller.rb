class ApplicationController < ActionController::API

  before_action :check_header
  before_action :validate_login

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

  def validate_login
    token = request.headers["X-Api-Key"]
    return unless token
    user = User.find_by token: token
    return unless user
    if 15.minutes.ago < user.updated_at
      user.touch
      @current_user = user
    end
  end

  def validate_user
    head :forbidden and return unless @current_user
  end

  def default_meta
    {
      licence: 'CC-0',
      authors: ['akm'],
      logged_in: (@current_user ? true : false)
    }
  end
end
