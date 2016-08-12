class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :validate_user, only: [:create, :update, :destroy]
  before_action :validate_type, only: [:create, :update]

  # GET /posts
  def index
    @posts = Post.all
    if params[:filter]
      @posts = @posts.where(["category = ?", params[:filter]])
    end
    if params[:sort]
      f = params[:sort].split(',').first
      field = f.sub(/\A\-/, '')
      order = (f =~ /\A\-/) ? 'DESC' : 'ASC'
      if Post.new.has_attribute?(field)
        @posts = @posts.order("#{field} #{order}")
      end
    end
    @posts = @posts.paginate(:page => params[:page])
    render json: @posts, meta: pagination_meta(@posts).merge(default_meta), include: ['user']
  end

  private def pagination_meta(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.previous_page,
      total_pages: object.total_pages,
      total_count: object.total_entries
    }
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = @current_user
    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end
