get '/' do
  erb :index
end

get '/about' do
  erb :about
end

get '/contact' do
  erb :contact
end

post '/email' do
    email = Mail.new
    email.from = params[:email]
    email.to = "acreilly3@gmail.com"
    email.subject = "#{params[:company]} is trying to contact you"
    email.body = "Name:  #{params[:full_name]} \n Company:  #{params[:company]} \n \n #{params[:message]}"

    email.delivery_method :sendmail
    email.deliver
    redirect "/contact"
end