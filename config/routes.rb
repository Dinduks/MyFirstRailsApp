Ecommerce::Application.routes.draw do
  scope ":locale" do
    devise_for :users
    resources  :cart
    resources  :products do
      match "/commander"   => "products#commander",    :as => "commander"
      match "/recommander" => "products#recommander",  :as => "recommander"
    end
    match "/forbidden"     => "application#forbidden", :as => "forbidden"
    match "/:locale/"      => "index#index",           :as => "index"
    match "/"              => "index#index",           :as => "index"
    root :to => "index#index"
  end
end
