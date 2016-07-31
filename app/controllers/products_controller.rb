#require "receipts/version"
#require "receipts/receipt"

class ProductsController < ApplicationController
    #include CurrentCart
  #before_action :set_cart
  before_action :set_product, only: [:show, :edit, :destroy]
  before_action :ban_path, only: [:show]

  respond_to :html, :js, :json
  #before_action :user_activated?
  
  def data
    products = Product.all
    # Respond to request with post data in json format
    respond_to do |format|
      format.json {  render :json =>  products.as_json }
    end
  end
  

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @user=User.find(@product.user_id)
    @info=@user.info
     respond_to do |format|
      format.html
      format.pdf {send_data @product.receipt.render, filename: "#{@product.title}-receipt.pdf", type: "application/pdf", disposition: :attachment}
      format.js
    end
  end
  
  # GET /products/new
  def new
    @product = Product.new
    respond_modal_with @product
  end

  # GET /products/1/edit
  def edit
    respond_modal_with @product
  end

  # POST /products
  # POST /products.json
  def create

    @angular = Product.new

    @angular.title=params[:products][:title]
    @angular.description=params[:products][:description]
    if user_signed_in?
      @angular.update_attributes(user_id: current_user.id)
    end
    if @angular.valid?
      @angular.save!
    end
     respond_to do |format|
       format.html { redirect_to angulars_url }
      format.json { render :json => @angular.as_json }
    end


    #@product = current_user.products.build(product_params)
    #@product.update_attributes(title: save_title(@product.title))
   
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @angular = Product.find(params[:id])
    
    @angular.update_attributes(title: params[:products][:title], description: params[:products][:description])
    respond_to do |format|
      if @angular.valid?
        format.html { redirect_to store_index_path, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @angular.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def mobile
    @products = Product.where(category: "Mobile").paginate(:page => params[:page], :per_page => Configurable['products_per_page'])
    @product= @products.first
    render "store/index"
  end  

  def car
    @products = Product.where(category: "Car").paginate(:page => params[:page], :per_page => Configurable['products_per_page'])
    @product= @products.first
    render "store/index"
  end  
  
   def laptop
    @products = Product.where(category: "Laptop").paginate(:page => params[:page], :per_page => Configurable['products_per_page'])
    @product= @products.first
    render "store/index"
  end  

   def telephone
    @products = Product.where(category: "Mobile").paginate(:page => params[:page], :per_page => Configurable['products_per_page'])
    @product= @products.first
    render "store/index"
  end  
  

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_product
    begin
      @product = Product.find(params[:id])
    rescue
      raise Cinema::NotFound 
    end
  end
   
      def scoped_products
      if current_role?(:author)
        Blog.for_role(current_role)
      else
        Blog.published.for_role(current_role)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:user_id, :category, :title, :full_description,:description, :uploaded_file, :price)
    end
end
