class Admin::ProductsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @products = Product.page(params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: "商品の作成が完了しました！"
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @genre = Genre.find(@product.genre_id)
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "商品の編集が完了しました！"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, notice: "商品の削除が完了しました！"
  end

  private

  def product_params
    params.require(:product).permit(:genre_id, :name, :explanation, :price, :tax_rate, :image, :sales_status)
  end
end
