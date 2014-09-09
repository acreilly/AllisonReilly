require 'pry'
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
    address: "smtp.gmail.com",
    port: 587,
    domain: "www.allisoncreilly.com",
    user_name: ENV['GMAIL'],
    password: ENV['PASSWORD'],
    authentication: "plain",
    :enable_starttls_auto => true
  }
    email = Mail.new
    email.from = params[:email]
    email.to = "acreilly3@gmail.com"
    email.subject = "#{params[:company]} is trying to contact you"
    email.body = "Name:  #{params[:full_name]} \n Company:  #{params[:company]} \n \n #{params[:message]}"

    email.delivery_method :smtp, options

    if email.deliver!
    redirect "/contact"
  else
redirect '/'
  end
end



get '/portfolio' do
  @images = Image.all.reverse
  @dev = Image.where(category: "dev")
  @design = Image.where(category: "design").reverse
  @photography = Image.where(category: "photography")
  erb :portfolio
end

get '/portfolio/dev' do
  @dev = Image.where(category: "dev")
  erb :dev, layout: false
end


get '/portfolio/design' do
  @design = Image.where(category: "design")
  erb :design, layout: false
end


get '/portfolio/photography' do
  @photography = Image.where(category: "photography")
  erb :photography, layout: false
end