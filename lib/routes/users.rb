get '/login' do
  haml :'users/login'
end

post '/login' do
  user = User.find_by_email(params[:email])
  user ||= User.create(:email => params[:email])
  user.password = params['password']
  login! user
  redirect '/emails'
end

get "/logout" do
  logout
  redirect "/login"
end