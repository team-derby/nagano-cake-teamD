class Admin::GenresController < ApplicationController

	def index
		@genre =Genre.new
		@genres = Genre.page(params[:page])
	end

	def create
		@genre = Genre.new(genre_params)
    if @genre.save
      redirect_to request.referer, notice: "ジャンルの作成が完了しました！"
    else
    	@genres = Genre.page(params[:page])
      render :index
    end
	end

	def edit
		@genre = Genre.find(params[:id])
	end

	def update
		@genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンルの編集が完了しました！"
    else
      render :edit
    end
	end

	def destroy
	end

	private

  def genre_params
    params.require(:genre).permit(:name, :active_status)
  end

end
