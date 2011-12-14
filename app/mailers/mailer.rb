class Mailer < ActionMailer::Base
  default :from => "samy@dindane.com"
  
  def recommendation_email(name, email, article)
    @name = name
    subject = I18n.t :recommendation_email_subject, 
                     :article_name => article.titre,
                     :name         => name
    mail(
      :to      => email, 
      :subject => subject
    )
  end
end
