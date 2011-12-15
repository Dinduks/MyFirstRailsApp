class Mailer < ActionMailer::Base
  default :from => "samy@dindane.com"

  def recommendation_email(product, recommandation)
    @name = recommandation.name
    subject = I18n.t :recommendation_email_subject,
                     :product_name => product.title,
                     :name         => @name
    mail(
      :to      => recommandation.email,
      :subject => subject
    )
  end
end
