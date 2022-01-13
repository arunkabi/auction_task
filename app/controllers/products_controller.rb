class ProductsController < ApplicationController
	def index
		@page = params.fetch(:page, 0).to_i

		if params[:sort_by].to_i == 2
			@all_products = Product.includes(:category).order("categories.category_name ASC")
		elsif params[:sort_by].to_i == 3
			@all_products = Product.includes(:user).order("users.user_name ASC")
		elsif params[:sort_by].to_i == 4
			@all_products = Product.all.order(product_name: :ASC)
		else
			@all_products = Product.all.order(id: :desc)
		end

		@all_products = @all_products.offset(@page*2).limit(2)
	end

	def new
		@product = Product.new()
	end

	def create
		@product = Product.new(product_params)

		if @product.save
			flash[:success] = "Product successfully created!"
			redirect_to root_path
		else
			render :new
		end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])

		if @product.update(product_params)
			flash[:success] = "Product successfully updated!"
			redirect_to root_path
		else
			render :edit
		end
	end

	def destroy
		@product = Product.find(params[:id])

		if @product.destroy
			flash[:success] = "Product successfully deleted!"
			redirect_to root_path
		else
			render :destroy
		end
	end

	def sorting
		if params[:sort_by].to_i == 2
			@all_products = Product.includes(:category).order("categories.category_name ASC")
		elsif params[:sort_by].to_i == 3
			@all_products = Product.includes(:user).order("users.user_name ASC")
		elsif params[:sort_by].to_i == 4
			@all_products = Product.all.order(product_name: :ASC)
		else
			@all_products = Product.all.order(id: :desc)
		end

		@all_products = @all_products.limit(2)

    respond_to do |format|
      format.js {render layout: false}
      format.html { render 'sorting'}
    end
	end

	def pagination
		@page = params.fetch(:page, 0).to_i

		if params[:sort_by].to_i == 2
			@all_products = Product.includes(:category).order("categories.category_name ASC")
		elsif params[:sort_by].to_i == 3
			@all_products = Product.includes(:user).order("users.user_name ASC")
		elsif params[:sort_by].to_i == 4
			@all_products = Product.all.order(product_name: :ASC)
		else
			@all_products = Product.all.order(id: :desc)
		end

		@original_size = (@all_products.size / 2)

		@all_products = @all_products.offset(@page * 2).limit(2)

    respond_to do |format|
      format.js {render layout: false}
      format.html { render 'pagination'}
    end
	end

	private
	def product_params
		params.require(:product).permit(:product_name, :category_id, :user_id)
	end
end
