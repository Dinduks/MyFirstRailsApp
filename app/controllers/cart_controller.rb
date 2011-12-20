#encoding: utf-8
class CartController < ApplicationController
  before_filter :get_product, :set_title
  respond_to :html

  def index
    if !session.has_key?(:cart) || session[:cart].empty?
      return render 'empty_cart'
    end
    @products = Product.find session[:cart]
    respond_with @products
  end

  def destroy
    id = params[:id].to_i
    times_to_add = session[:cart].count(id) - 1
    session[:cart].delete(id)
    times_to_add.times do
      session[:cart] << id
    end
    flash[:success] = I18n.t :article_retire_du_panier
    flash[:success] += '!'
    redirect_to :action => "index"
  end

  private
  def get_product
    id = params[:id]
    if id
      @product = Product.find id
    end
  end

  def set_title
    @page_title = I18n.t :Panier
  end
end
