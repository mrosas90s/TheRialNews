class NewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  
  # Resto del código del controlador
  
  # GET /news or /news.json
  def index
    @news = News.all
  end

  # GET /news/1 or /news/1.json
  def show
    @comment = @news.comments.build(parent_id: params[:parent_id])
    @comments = @news.comments.where(parent_id: nil)
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news or /news.json
  def create
    @news = current_user.news.build(news_params)
  
    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: "News was successfully created." }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /news/1 or /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to news_url(@news), notice: "News was successfully updated." }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1 or /news/1.json
  def destroy
    @news.destroy
  
    redirect_to news_index_url, notice: "News deleted successfully."
  end
  
  
  
  
  private
  
  def set_news
    @news = News.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path, alert: "You are not authorized to perform this action." unless @news.user == current_user
  end

  def news_params
    params.require(:news).permit(:title, :content)
  end
end
