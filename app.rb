# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'fileutils'

enable  :method_override

get '/' do
  file_names = Dir.glob('./memo_data/*')
  @file_numbers = file_names.map { |fn| fn.delete!('^0-9').to_i }.sort
  erb :top
end

post '/' do
  file_names = Dir.glob('./memo_data/*')
  file_numbers = file_names.map { |fn| fn.delete!('^0-9').to_i }.sort
  latest_number = file_numbers.max
  memo_file = File.open("./memo_data/#{latest_number + 1}", 'w', 0o0666)
  memo_file.puts params[:memo]
  memo_file.close
  redirect to('/')
end

get '/show_*' do |num|
  @num = num
  erb :show
end

get '/new' do
  erb :new
end

delete '/delete_*' do |num|
  FileUtils.rm("./memo_data/#{num}")
  redirect to('/')
end

get '/edit_*' do |num|
  @num = num
  erb :edit
end

patch '/update_*' do |num|
  memo_file = File.open("./memo_data/#{num}", 'w')
  memo_file.puts params[:memo]
  memo_file.close
  redirect to('/')
end
