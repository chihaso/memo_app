# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'fileutils'

enable  :method_override

def random_number_generator(n)
  ''.dup.tap { |s| n.times { s << rand(0..9).to_s } }
end

# トップ（index）ページ
get '/' do
  file_names = Dir.glob('./memo_data/*')
  @first_lines = []
  file_names.each { |fn| @first_lines << File.open(fn, 'r').gets }
  @file_numbers = file_names.map { |fn| fn.delete!('^0-9').to_i }
  erb :top
end

# 新規メモ作成ページ
get '/new' do
  erb :new
end

# 新規メモ作成
post '/' do
  memo_file = File.open("./memo_data/#{random_number_generator(10)}", 'w', 0o0666)
  memo_file.puts params[:memo]
  memo_file.close
  redirect to('/')
end

# メモ編集ページ
get '/edit_*' do |num|
  @num = num
  erb :edit
end

# メモ更新
patch '/*' do |num|
  memo_file = File.open("./memo_data/#{num}", 'w')
  memo_file.puts params[:memo]
  memo_file.close
  redirect to('/')
end

# メモ削除
delete '/*' do |num|
  FileUtils.rm("./memo_data/#{num}")
  redirect to('/')
end

# メモ表示ページ
get '/*' do |num|
  @num = num
  erb :show
end
