#encoding: utf-8
class PanierController < ApplicationController
  before_filter :get_product, :set_title
  respond_to :html

  def index
    if !session.has_key?(:panier) || session[:panier].empty?
      return render 'empty_panier'
    end
    @products = Product.find session[:panier]
    respond_with @products
  end

  def destroy
    session[:panier].delete(params[:id].to_i)
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
