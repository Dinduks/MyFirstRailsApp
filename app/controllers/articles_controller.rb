#encoding: utf-8
class ArticlesController < ApplicationController
  before_filter :get_article, :set_title
  respond_to    :html

  def index
    @page_small_title = I18n.t :liste_articles
    @articles = Article.all
    respond_with @articles
  end

  def destroy
    if !current_user.admin
      raise Errors::AccessDenied
    end
    @article.destroy
    respond_with @article
  end

  def new
    if !current_user.admin
      raise Errors::AccessDenied
    end
    @page_small_title = I18n.t :ajouter_article
    @article = Article.new
    respond_with @article
  end

  def create
    @article = Article.new params[:article]
    @article.save
    redirect_to :action => "index"
  end

  def edit
    if !current_user.admin
      raise Errors::AccessDenied
    end
    respond_with @article
  end

  def update
    @article.update_attributes params[:article]
    respond_with @article
  end

  def commander
    session[:panier] ||= []
    session[:panier] << @article.id
    flash[:success] = @article.titre + " a été ajouté au panier!"
    redirect_to :action => "index"
  end

  def show
    @recommendation = Recommendation.new
    respond_with @article
  end

  def recommander
    @article = Article.find params[:article_id]

    name = params[:recommendation][:name]
    email = params[:recommendation][:email]

    recommendation = Recommendation.new
    recommendation.name = name
    recommendation.email = email
    recommendation.user_id = current_user.id
    recommendation.save

    Mailer::recommendation_email(name, email, @article).deliver

    render :nothing => true
  end

  private
  def get_article
    id = params[:id] || params[:article_id]
    if id
      @article = Article.find id
    end
  end

  def set_title
    @page_title = I18n.t :Articles
  end
end
