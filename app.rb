require 'sinatra'
require 'sinatra/reloader'
require 'fileutils'

get '/' do
  @file_numbers = Dir.glob('./memo_data/*').map { |fn|
    fn.delete('^0-9').to_i
  }.sort
  erb :top
end

get '/show_*' do |num|
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
  redirect to('/')
end

post '/delete_*' do |num|
  FileUtils.rm("./memo_data/#{num}")
  redirect to('/')
end

get '/edit_*' do |num|
  @num = num
  erb :edit
end

post '/update_*' do |num|
  File.open("./memo_data/#{num}", 'w') { |f|
    f.puts params[:memo]
  }
  redirect to('/')
end
