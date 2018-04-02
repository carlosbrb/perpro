require 'cuba'
require 'cuba/safe'
require 'cuba/contrib'
require 'basica'
require 'mongoid'
require 'mote'
require 'mote/render'
require 'dotenv/load'
require 'shield'
require 'pry'

Mongoid.load!('config/mongoid.yml', :development)

Cuba.use Rack::Session::Cookie, secret: ENV['SECRET']
Cuba.use Rack::Static, urls: ["/public/css"]

Cuba.plugin Cuba::Safe
Cuba.plugin(Mote::Render)
Cuba.plugin Shield::Helpers
Cuba.plugin Cuba::Mote

Dir["./models/**/*.rb"].each  { |rb| require rb }
Dir["./routes/**/*.rb"].each  { |rb| require rb }

Cuba.define do
  persist_session!
  on get do
    on 'home' do
      me = Me.first
      me.blank? ? res.write("You didn't setup your profile") : res.write(view('home', me: me))
    end

    on 'admin' do
      run Admins
    end

    on 'install' do
      run Installs
    end

    on root do
      res.redirect '/home'
    end
  end
end
