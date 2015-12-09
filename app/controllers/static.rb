get '/' do
  if session[:user_id] == nil
    erb :"static/index"
  else
    @user = User.find(session[:user_id])
  	erb :'user/show'
  end
end
