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
  options = {
    address: "smtp.secureserver.net",
    port: 25,
    domain: "allisoncreilly.com",
    user_name: "#{ENV['USERNAME']}",
    password: "#{ENV['PASSWORD']}",
    authentication: "plain"
  }
    email = Mail.new
    email.from = params[:email]
    email.to = "acreilly3@gmail.com"
    email.subject = "#{params[:company]} is trying to contact you"
    email.body = "Name:  #{params[:full_name]} \n Company:  #{params[:company]} \n \n #{params[:message]}"
binding.pry

    email.delivery_method :smtp, options
    if email.deliver
    redirect "/contact"
  end
end



get '/portfolio' do
  erb :portfolio
end