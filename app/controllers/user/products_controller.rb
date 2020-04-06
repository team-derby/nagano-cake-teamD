class User::ProductsController < ApplicationController
  def index
    # ジャンルテーブルと結合させ、ジャンルテーブルが有効なレコードを取得
    @products = Product.joins(:genre => :products).where(genres: { active_status: 0})
    @genres = Genre.where(active_status: 0)
    # kaminari(ページング)用
    @product = Product.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @genres = Genre.where(active_status: 0)
  end

  def genre
    @products = Product.where(genre_id: params[:id])
    @genres = Genre.where(active_status: 0)
  end
end
