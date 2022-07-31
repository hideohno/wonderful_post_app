class MypageController < ApplicationController
  def show
    #@articles = current_user.articles.page(params[:page])

    if params[:title].present?
      @articles = current_user.articles.where("title like ?","%#{params[:title]}%").page(params[:page])
    else
      @articles = current_user.articles.page(params[:page])
    end
  end
end
