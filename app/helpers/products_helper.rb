module ProductsHelper
  
  def get_formatted_price(price)
    if price % price.to_i == 0
      return price.to_i
    else
      return price
    end
  end
  
end
