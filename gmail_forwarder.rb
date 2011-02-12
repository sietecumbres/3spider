require 'rubygems'

require 'bundler'
Bundler.setup

require 'sinatra'
require 'digest/sha1'
require 'mongoid'
require 'sinatra/memcache'
require 'mail'
require 'mime'
require 'lib/helpers'

#usages
helpers do
  include Helpers
end

#Require Models
%w(user gmail_adapter contact email).each do |model|
  require "lib/models/#{model}"
end

#Require Routes
%w(users emails contacts).each do |route|
  require "lib/routes/#{route}"
end

#Configuration
Mongoid.configure do |config|
  name = 'gmail_forwarder'
  host = 'localhost'
  config.master = Mongo::Connection.new.db(name)
end

configure do
  enable :sessions, :logging
  set :haml, {:format => :html5, :escape_html => true}
end

CONTENT_TYPES = {:html => 'text/html', :css => 'text/css', :js => 'application/javascript',
  :json => 'application/json', :xml => 'text/xml'}
before do
  request_uri = case request.env['REQUEST_URI']
    when /\.css$/ : :css
    when /\.js$/ : :js
    when /\.xml$/ : :xml
    when /\.json$/ : :json
    else :html
  end
  content_type CONTENT_TYPES[request_uri], :charset => 'utf-8'
end

#basic routes
get '/' do
  login_required
  haml :index, {:layout => :layout}
end