class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show ]
  before_action :set_article, only: %i[ edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.page(params[:page])
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.find(params[:id])
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
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article, notice: "記事を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    @article = current_user.articles.new(article_params)
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
      @article = current_user.articles.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
