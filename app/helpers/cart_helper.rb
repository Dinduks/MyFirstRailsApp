module CartHelper
  def get_cart_status
    if !session[:cart].nil? && !session[:cart].empty?
      cart_counter = session[:cart].count.to_s
      if session[:cart].count == 1
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
