require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Ecommerce
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
    config.assets.version = '1.0'
    
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address   => "mail.naravia.com",
      :port      => 25,
      :user_name => "staff@naravia.com",
      :password  => "cats"
    }
  end
end

