require 'spec_helper'

describe CartController do
  include Devise::TestHelpers
  
  before :each do
    @user = Factory(:user)
    sign_in @user
  end
  
  describe "DELETE destroy" do
    it "should remove the item from session" do
      product = Factory(:product)
      session[:cart] = {product.id => 3}
      delete :destroy, :locale => 'en', :id => product.id
      session[:cart][product.id].should eql(2)
    end
    
    it "should remove the product from the session if its quantity equals 0" do
      product = Factory(:product)
      session[:cart] = {product.id => 1}
      delete :destroy, :locale => 'en', :id => product.id
      session[:cart][product.id].should eql(nil)
    end
  end
  
end