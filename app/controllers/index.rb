require 'net/smtp'

get '/' do
  @body_class = 'home_page'
  erb :index
end

get '/about' do
  @body_class = 'about_page'
  erb :about
end

get '/contact' do
  @body_class = 'contact_page'
  erb :contact
end

post '/email' do
  Mail.defaults do
    delivery_method :smtp, {
      address: 'smtp.gmail.com',
      port: '587',
      user_name: ENV['GMAIL'],
      password: ENV['PASSWORD'],
      domain: 'gmail.com',
      authentication: :plain,
      enable_starttls_auto: true
    }
  end
  email = Mail.new
  email.from = params[:email]
  email.to = "acreilly3@gmail.com"
  email.subject = "#{params[:company]} is trying to contact you"
  email.body = "Name:  #{params[:full_name]} \n Email:  #{params[:email]} \n Company:  #{params[:company]} \n \n #{params[:message]}"

  if email.deliver
    redirect "/contact"
  end
end



get '/portfolio' do
  @images = Image.all.reverse
  @dev = Image.where(category: "dev")
  @design = Image.where(category: "design").reverse
  @photography = Image.where(category: "photography")
  @body_class = 'portfolio_page'
  erb :portfolio
end

get '/portfolio/all' do
  @images = Image.all.reverse
  @body_class = 'portfolio_page'
  erb :all, layout: false
end

get '/portfolio/dev' do
  @dev = Image.where(category: "dev")
  @body_class = 'dev_page'
  erb :dev, layout: false
end


get '/portfolio/design' do
  @design = Image.where(category: "design")
  @body_class = 'design_page'
  erb :design, layout: false
end


get '/portfolio/photography' do
  @photography = Image.where(category: "photography")
  @body_class = 'photography_page'
  erb :photography, layout: false
end

get '/portfolio/image/:id' do
  @image = Image.find(params[:id])
  @body_class = 'image_page'
  erb :image
end


get '/mathiasaschulien' do
  @body_class = 'wedding_site'
  erb :mathiasaschulien
end

post '/mathiasaschulien/rsvp' do
  res = {response: []}
  party = WeddingParty.create(email: params[:wedding_party][:email])
  params[:wedding_guests].each_value do |wedding_guest|
    guest = party.guests.create(wedding_guest)

    if guest.errors.messages.any?
      res[:response] << guest.errors.messages.values.flatten.first
    end
  end

  res[:response] << 'Thanks!' if res[:response].empty?

  halt 200, res.to_json
end