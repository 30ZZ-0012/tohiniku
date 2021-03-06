require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

enable :sessions

get '/' do
  @items = Item.all
  @total = Item.sum(:price)
  @categories = Category.all
  @evaluation =""
  # binding.pry
  random = rand(1..5)
  if getPercentageOfWalk < 0.4
    if random == 2
    @evaluation = "images/100.jpg"
    else
    @evaluation = "images/iwai.jpg"
    end
  else
    if random == 1
    @evaluation = "images/burankp.jpg"
    else
    @evaluation = "images/tamasi.jpg"
    end
  end
  erb :index
end

post '/create' do
  Item.create({
       title: params[:title],
       price: params[:price],
       category_id: params[:category],
       count: 1,
       datetime: params[:time],
       color: params[:color]
  })
  redirect '/'
end

get '/category/:id' do
  @categories    = Category.all
  @category  = Category.find(params[:id])
  @category_name = @category.name
  @items         = @category.items
  erb :index
end
post'/delete/:id' do
  Item.find(params[:id]).destroy
  redirect '/'
end

post '/edit/:id' do
  @item = Item.find(params[:id])
  erb :edit
end

post '/renew/:id' do
  @item = Item.find(params[:id])
  @item.update({
    title: params[:title],
    price: params[:price]
  })
  redirect '/'
end


post '/plus/:id' do
  count = Item.find_by(id: params[:id])
  count.price = count.price + 1000
  count.save
  redirect '/'
end

post '/minus/:id' do
  count = Item.find_by(id: params[:id])
  count.price = count.price - 1000
  count.save
  redirect '/'
end

post '/delete/:id' do
  count = Item.find_by(id: params[:id])
  count.destroy
  redirect '/'
end

def getPercentageOfWalk
  item = Item.find_by(title:"歩き")
  return item.price/Item.sum(:price)
end

get '/signin' do
  erb :sign_in
end

get '/signup' do
  erb :sign_up
end

post '/signin' do
  user = User.find_by(mail: params[:mail])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

post '/signup' do
  @user = User.create(mail:params[:mail],password:params[:password],
  password_confirmation:params[:password_confirmation])
  if @user.persisted?
    session[:user] = @user.id
  end
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end