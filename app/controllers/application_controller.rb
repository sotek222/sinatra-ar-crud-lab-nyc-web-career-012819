
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  get "/articles/new" do
    erb :new
  end

  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  post "/articles" do
    title = params[:title]
    content = params[:content]
    article = Article.create(title: title, content: content)
    redirect "/articles/#{article.id}"
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    article = Article.find(params[:id])
    article.update(title: params[:title], content: params[:content])

    redirect "/articles/#{article.id}"
  end

  delete '/articles/:id/delete' do
    @article = Article.find_by_id(params[:id])
    @article.delete
    redirect "/articles"
  end

end
