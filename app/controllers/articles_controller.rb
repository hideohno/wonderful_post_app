class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  #before_action :baria_user, only: [:edit, :destroy]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params,user_id: @current_user.id)
    if @article.save
      redirect_to @article, notice: "記事を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    if @article.update(article_params)
      redirect_to @article, notice: "記事を編集しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    edirect_to articles_url, notice: "記事を削除しました"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content)
    end

    # #投稿者のみ編集削除できるように
    # def baria_user
    #   unless Article.find(params[:id]).user_id == current_user.id
    #     flash[:notice] = "権限がありません"
    #     redirect_to articles_path
    #   end
    # end
end
