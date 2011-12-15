module PanierHelper
  def get_cart_status
    if !session[:panier].nil? && !session[:panier].empty?
      cart_counter = session[:panier].count.to_s
      if session[:panier].count == 1
        cart_counter += " "
        cart_counter += I18n.t :produit
      else
        cart_counter += " "
        cart_counter += I18n.t :produits
      end
    else
      cart_counter = I18n.t :vide
    end
    return cart_counter
  end
end
