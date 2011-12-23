module CartHelper

  def get_cart_status
    if !session[:cart].nil? && !session[:cart].empty?
      products_counter = 0
      session[:cart].each do |product|
        products_counter += product[1]
      end
      
      if products_counter == 1
        products_counter = products_counter.to_s
        products_counter += " "
        products_counter += I18n.t :produit
      else
        products_counter = products_counter.to_s
        products_counter += " "
        products_counter += I18n.t :produits
      end
      
      return products_counter
    else
      return I18n.t :vide
    end
  end

end
