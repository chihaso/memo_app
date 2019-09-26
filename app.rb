# frozen_string_literal: true

require "sinatra"
require "sinatra/reloader"
require "fileutils"
require "securerandom"
require "./lib/memo_list.rb"

# トップ（index）ページ
get "/" do
  memo_list = MyMemoApp::Memo_list.new("./memo_data/*")
  @memo_beginnings = memo_list.beginnings
  @memo_ids = memo_list.names
  erb :top
end

# 新規メモ作成ページ
get "/new" do
  erb :new
end

# 新規メモ作成
post "/" do
  File.open("./memo_data/#{SecureRandom.uuid}", "w", 0o0666) do |file|
    file.puts params[:memo]
  end
  redirect to("/")
end

# メモ編集ページ
get "/:id/edit" do
  @id = params[:id]
  @memo_text = File.read("./memo_data/#{@id}")
  erb :edit
end

# メモ更新
patch "/:id" do
  File.open("./memo_data/#{params[:id]}", "w") do |file|
    file.puts params[:memo]
  end
  redirect to("/")
end

# メモ削除
delete "/:id" do
  FileUtils.rm("./memo_data/#{params[:id]}")
  redirect to("/")
end

# メモ表示ページ
get "/:id" do
  @id = params[:id]
  @memo_text = File.read("./memo_data/#{@id}").gsub("\n", "<br>")
  erb :show
end
