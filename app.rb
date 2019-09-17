require 'sinatra'
require 'sinatra/reloader'
require 'fileutils'

get '/' do
  erb :top
end

get '/show/*' do |num|
  @num = num
  erb :show
end

get '/new' do
  erb :new
end

post '/create' do
  file_numbers = Dir.glob('./memo_data/*').map { |fn|
    fn.delete('^0-9').to_i
  }
  latest_number = file_numbers.max
  File.open("./memo_data/#{latest_number + 1}", 'w', 0o0777) { |f|
    f.puts params[:memo]
  }
  erb :top
end

post '/delete_*' do |num|
  FileUtils.rm("./memo_data/#{num}")
  erb :top
end
