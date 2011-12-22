require 'spec_helper'

describe ProductsController do
  include Devise::TestHelpers
  
  before :each do
    @user = Factory(:user)
    sign_in @user
  end
  
  describe "GET index" do
    it "should succeed" do
      get :index, :locale => 'en'
      response.should be_success
    end
  end
  
  describe "POST recommander" do
    it "should create a recommandation" do
      product = Factory(:product)
      name = 'moi'
      email = 'moi@moi.com'
      
      lambda do
        post :recommander, :product_id => product.id, :locale => 'en',
          :recommendation => {:name => name, :email => email}
      end.should change(Recommendation, :count).by(1)
    end
    
    it "should send an email" do
      product = Factory(:product)
      name = 'moi'
      email = 'moi@moi.com'
      
      lambda do
        post :recommander, :product_id => product.id, :locale => 'en',
          :recommendation => {:name => name, :email => email}
      end.should change(ActionMailer::Base.deliveries, :length).by(1) 
      
      emailSent = ActionMailer::Base.deliveries.last
      emailSent.to.should eql(['moi@moi.com'])
      emailSent.encoded.should match(/#{name}/)
      emailSent.encoded.should match(/#{product.title}/)
    end
  end
  
  describe "GET commander" do
    it "should add the product id to the session" do
      lambda do
        get :commander, :locale => 'en', :product_id => 42
      end.should do
        session.have_key(:cart)
        session[:cart].have_key(product.id)
      end
    end
    
    it "should increment the product's quantity in the session" do
      product = Factory(:product)
      session[:cart] = {product.id => 3}
      get :commander, :locale => 'en', :product_id => 42
      session[:cart][product.id].should eql(4)
    end
    
    it "should display a flash message" do
      product = Factory(:product)
      lambda do
        get :commander, :locale => 'en', :product_id => 42
      end.should do
        flash.have_key[:success]
        flash[:success].should_not be empty
        flash[:success].should match(/#{product.title}/)
      end
    end
    
    it "should redirect to the index" do
      product = Factory(:product)
      get :commander, :locale => 'en', :product_id => 42
      response.should redirect_to(:action => "index")
    end
  end
  
  describe "DELETE destroy" do
    it "should remove the product from the db" do
      product = Factory(:product)
      lambda do
        delete :destroy, :locale => 'en', :id => 42
      end.should change(Product, :count).by(-1)
    end
    it "should remove the product from the cart" do
      product = Factory(:product)
      session[:cart] = [product.id, 1, 10, product.id, product.id, 5, product.id]
      delete :destroy, :locale => 'en', :id => 42
      session[:cart].should eql([1, 10, 5])
    end
    it "should do nothing if the cart's empty" do
      product = Factory(:product)
      session[:cart] = []
      delete :destroy, :locale => 'en', :id => 42
      session[:cart].should eql([])
    end
    it "should do nothing if the cart's nil" do
      product = Factory(:product)
      session[:cart] = nil
      delete :destroy, :locale => 'en', :id => 42
      session[:cart].should eql(nil)
    end
  end
  
end