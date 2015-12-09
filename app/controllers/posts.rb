# Display new post form

get '/posts/new' do
  erb :"post/new"
end

# Create new post

post '/posts' do
  post = Post.create(title: params[:title], user_id: session[:user_id], body: params[:body])
  redirect "/posts/#{post.id}"
end

# Display post edit form

get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  erb :'post/edit'
end

# Update post

patch '/posts/:id/edit' do
  post = Post.find(params[:id])
  post.update(title: params[:title], body: params[:body])
  redirect "/posts/#{post.id}"
end

# Delete post

delete '/posts/:id' do
  post = Post.find(params[:id])
  post.destroy
  redirect "/users/#{session[:user_id]}"
end

# View post profile

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :'post/show'
end

# comment
post '/posts/:id/comment' do
  Comment.create(comment: params[:comment], user_id: session[:user_id], post_id: params[:id])
  redirect "/posts/#{params[:id]}"
end

get '/posts/:id/comment' do
  @post = Post.find(params[:id])
  erb :'comment/add'
end

get '/posts/:id/comment/:comment_id/edit' do
  @post = Post.find(params[:id])
  @comment = Comment.find(params[:comment_id])
  if @comment.user_id != session[:user_id]
    p 'Not Authorized'
  else
      erb :'comment/edit'
  end
end

patch '/posts/:id/comment/:comment_id/edit' do
  Comment.find(params[:comment_id]).update(comment: params[:comment])
  redirect "/posts/#{params[:id]}"
end

get '/posts/:id/comment/:comment_id/delete' do
  @comment = Comment.find(params[:comment_id])
  if @comment.user_id != session[:user_id]
    p 'Not Authorized'
  else
    Comment.delete(params[:comment_id])
    redirect "/posts/#{params[:id]}"
  end

end

# booking
post '/posts/:id/booking' do
  Booking.create(message: params[:message], user_id: session[:user_id], post_id: params[:id])
  redirect "/users/#{session[:user_id]}"
end

get '/posts/:id/booking' do
  @post = Post.find(params[:id])
  if @post.user_id == session[:user_id]
    p 'You Cannot Book Your Own Property'
  else
    erb :'booking/add'
  end
end

get '/posts/:id/booking/:booking_id/edit' do
  @post = Post.find(params[:id])
  @booking = Booking.find(params[:booking_id])
  if @booking.user_id != session[:user_id]
    p 'Not Authorized'
  else
    erb :'booking/edit'
  end
end

patch '/posts/:id/booking/:booking_id/edit' do
  Booking.find(params[:booking_id]).update(message: params[:message])
  redirect "/users/#{session[:user_id]}"
end

get '/posts/:id/booking/:booking_id/delete' do
  @booking = Booking.find(params[:booking_id])
  if @booking.user_id != session[:user_id]
    p 'Not Authorized'
  else
    Booking.delete(params[:booking_id])
    redirect "/users/#{session[:user_id]}"
  end
end
