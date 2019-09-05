class Manager::ProductsController < ManagerController
  before_action :load_product, except: %i(index create new)
  before_action :load_parent_comments, only: %i(show)

  def index
    @search = Product.ransack params[:search]
    @products = @search.result.page(params[:page])
      .products_of_current_user(product_ids_current_user)
      .per Settings.manager.product.num_in_page
  end

  def new
    @product = Product.new
  end

  def edit; end

  def show
    @comment = Comment.new
  end

  def create
    @product = Product.new product_params
    
    if @product.save
      flash[:success] = t(".success")
      redirect_to manager_products_path
    else
      render :new
    end
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t(".success")
      redirect_to manager_products_path
    else
      render :new
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t(".success")
    else
      flash[:danger] = t(".error")
    end
    redirect_to manager_products_url
  end

  private

  def product_ids_current_user
    current_user.products.pluck :id
  end

  def product_params
    params.require(:product).permit Product::PRODUCT_PARAMS
  end
  
  def load_product
    @product = Product.find_by_id params[:id]

    return if @product
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end

  def load_parent_comments
    @parent_comments = @product.comments.parent_comment
  end
end
