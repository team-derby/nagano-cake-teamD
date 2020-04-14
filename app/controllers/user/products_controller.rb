class User::ProductsController < ApplicationController

  def index
    # ジャンルテーブルと結合させ、ジャンルテーブルが有効なレコードを取得
    @products = @q.result.includes(:genre).where(genres: { active_status: 0}).page(params[:page])
    @genres = Genre.where(active_status: 0)
    @products_all = @q.result.includes(:genre).where(genres: { active_status: 0})
  end

  def show
    @product = Product.find(params[:id])
    @genres = Genre.where(active_status: 0)
    @cart_item = CartItem.new
  end

  def genre
    @products = Product.where(genre_id: params[:id])
    @genres = Genre.where(active_status: 0)
  end

end
