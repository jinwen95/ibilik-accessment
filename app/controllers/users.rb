# User login



post '/users/login' do
	user = User.find_by(email: params[:email], password: params[:password])
	session[:user_id] = user.id
	redirect "/users/#{user.id}"
end

# User logout

get '/users/logout' do
	session[:user_id] = nil
	redirect '/'
end

# Display new user form

get '/users/new' do
	erb :"user/new"
end

# Create new user

post '/users' do
	user = User.create(name: params[:name], email: params[:email], password: params[:password])
	session[:user_id] = user.id
	redirect "/users/#{user.id}"
end

# Display user edit form

get '/users/:id/edit' do
	@user = User.find(params[:id])
	erb :'user/edit'
end

# Update user

patch '/users/:id' do
	user = User.find(params[:id])
	user.update(name: params[:name], email: params[:email], password: params[:password], description: params[:description])
	redirect "/users/#{user.id}"
end

# Delete user

delete '/users/:id' do
	user = User.find(params[:id])
	user.destroy
	erb :'static/index'
end

# View user profile

get '/users/:id' do
	@user = User.find(params[:id])
	erb :'user/show'
end

# View login page

get '/users' do
	erb :'user/index'
end
