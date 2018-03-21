require 'cuba'
require 'cuba/safe'
require 'cuba/contrib'
require 'mongoid'
require 'mote'
require 'mote/render'

Mongoid.load!('config/mongoid.yml', :development)

Cuba.use Rack::Session::Cookie, secret: 'ItVkZphTrBUkiRkh3ajLf9NQePwoxLPJGCExzBu1EY0r82G3TrzTSvmvFF1e'

Cuba.plugin Cuba::Safe
Cuba.plugin(Mote::Render)

Cuba.define do
  on get do
    on 'home' do
      res.write view("home")
    end
  end
end
