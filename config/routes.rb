Ecommerce::Application.routes.draw do
  scope ":locale" do
    devise_for :users
    resources  :panier
    resources  :articles do
      match "/commander"   => "articles#commander",    :as => "commander"
      match "/recommander" => "articles#recommander",  :as => "recommander"
    end
    match "/forbidden"     => "application#forbidden", :as => "forbidden"
    match "/:locale/"      => "index#index", :as => "index"
    match "/"      => "index#index", :as => "index"
    root :to => "index#index"
  end
end
