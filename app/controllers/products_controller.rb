#encoding: utf-8
class ProductsController < ApplicationController
  before_filter :get_product, :set_title
  before_filter :require_admin!,
    :only => [:destroy, :new, :create, :edit, :update]
  respond_to    :html

  def index
    @page_small_title = I18n.t :liste_articles
    @products = Product.all
    respond_with @products
  end

  def destroy
    @product.destroy
    if !session[:cart].nil? && !session[:cart].empty?
      session[:cart].delete(@product.id)
    end
    respond_with @product
  end

  def new
    @page_small_title = I18n.t :ajouter_article
    @product = Product.new
    respond_with @product
  end

  def create
    @product = Product.new params[:product]
    @product.save
    redirect_to :action => "index"
  end

  def edit
    respond_with @product
  end

  def update
    @product.update_attributes params[:product]
    respond_with @product
  end

  def commander
    session[:cart] = CartUtility.add_product(session[:cart], @product.id, 1)
    flash[:success] = @product.title + " a été ajouté au panier!"
    redirect_to :action => "index"
  end

  def show
    @recommendation = Recommendation.new
    respond_with @product
  end

  def recommander
    @product = Product.find params[:product_id]
    recommandation = Recommendation.create params[:recommendation].merge(:user_id => current_user.id)

    if recommandation
      Mailer::recommendation_email(@product, recommandation).deliver
    end

    render :nothing => true
  end

  private
  def get_product
    id = params[:id] || params[:product_id]
    if id
      @product = Product.find id
    end
  end

  def set_title
    @page_title = I18n.t :Articles
  end
end
