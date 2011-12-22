module CartUtility

  def self.add_product(session_cart, product_id, quantity)
    session_cart ||= {}
    if session_cart.has_key? product_id
      session_cart[product_id] += quantity
    else
      session_cart[product_id] = quantity
    end
    return session_cart
  end
  
  def self.remove_product(session_cart, product_id, quantity)
    session_cart[product_id] -= quantity
    session_cart.delete(product_id) unless session_cart[product_id] > 0
    return session_cart
  end
  
end