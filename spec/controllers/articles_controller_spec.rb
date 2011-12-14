require 'spec_helper'

describe ArticlesController do
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
      article = Factory(:article)
      name = 'moi'
      email = 'moi@moi.com'
      
      lambda do
        post :recommander, :article_id => article.id, :locale => 'en',
          :recommendation => {:name => name, :email => email}
      end.should change(Recommendation, :count).by(1)
    end
    
    it "should send an email" do
      article = Factory(:article)
      name = 'moi'
      email = 'moi@moi.com'
      
      lambda do
        post :recommander, :article_id => article.id, :locale => 'en',
          :recommendation => {:name => name, :email => email}
      end.should change(ActionMailer::Base.deliveries, :length).by(1) 
      
      emailSent = ActionMailer::Base.deliveries.last
      emailSent.to.should eql(['moi@moi.com'])
      emailSent.encoded.should match(/#{name}/)
      emailSent.encoded.should match(/#{article.titre}/)
    end
  end
  
  describe "GET commander" do
    it "should add the product id to the session" do
      lambda do
        get :commander, :locale => 'en', :article_id => 42
      end.should do
        session.have_key(:panier)
        session[:panier].have_key(article.id)
      end
    end
    
    it "should display a flash message" do
      article = Factory(:article)
      lambda do
        get :commander, :locale => 'en', :article_id => 42
      end.should do
        flash.have_key[:success]
        flash[:success].should_not be empty
        flash[:success].should match(/#{article.titre}/)
      end
    end
    
    it "should redirect to the index" do
        article = Factory(:article)
      lambda do
        get :commander, :locale => 'en', :article_id => 42
      end.should do
        response.should redirect_to(:action => "index")
      end
    end
  end
  
end