require 'sinatra'

get '/' do
  @message = 'Docker!'
  erb :index
end
