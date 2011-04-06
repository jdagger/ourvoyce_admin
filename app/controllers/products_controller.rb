class ProductsController < ApplicationController
  def index

    @paging = PagingHelper::PagingData.new

    if ! params[:filter_upc].blank?
      redirect_to :filter => "upc=#{params[:upc]}"
    elsif ! params[:filter_text].blank?
      redirect_to :filter => "text=#{params[:text]}"
    end

    if ! params[:filter].blank?
      case params[:filter].downcase
      when 'default_include'
        @products = Product.default_include
      when 'pending'
        @products = Product.pending
      else
        type, filter = params[:filter].split('=')
        case type
        when 'upc'
          @products = Product.where("upc = ? or ean = ?", filter, filter)
        else
          #@products = Product.search filter
          @products = Product.where("1=1")
        end
      end
    else
        @products = Product.where("1=1")
    end
    page_size = 100 
    page = [params[:page].to_i, 1].max
    @products = @products.order("name asc") 

    @product_count = @products.count
    @products = @products.offset((page - 1) * page_size).limit(page_size)
    @paging.total_pages = (@product_count.to_f / page_size).ceil
    @paging.current_page = page
    (1..@paging.total_pages).each do |count|
      link = {:link_url => url_for(:controller => "products", :action => 'index', :page => count, :sort => params[:sort]), :page => count}
      @paging.links << link
    end
  end


  def new
    @product = Product.new;
  end


  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to(product_path(@product), :notice => 'Product was successfully created.')
    else
      render :action => "new"
    end
  end


  def show
    @product = Product.find(params[:id])
  end


  def edit
    @product = Product.find(params[:id])
  end


  def update
    @product = Product.find(params[:id]) 
    if @product.update_attributes(params[:product])
      redirect_to(product_path(@product), :notice => 'Product was successfully updated.')
    else
      render :action => "edit"
    end
  end


  def destroy 
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to(products_path)
  end
end
