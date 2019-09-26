# frozen_string_literal: true

require "sinatra"
require "sinatra/reloader"
require "fileutils"
require "./lib/memo_list.rb"
require "./lib/new_memo.rb"
require "./lib/memo.rb"

# トップ（index）ページ
get "/" do
  memo_list = MyMemoApp::MemoList.new("./memo_data/*")
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
  MyMemoApp::NewMemo.new("./memo_data/", params[:memo]).save
  redirect to("/")
end

# メモ編集ページ
get "/:id/edit" do
  @id = params[:id]
  @memo_text = MyMemoApp::Memo.new("./memo_data/#{@id}").memo_text
  erb :edit
end

# メモ更新
patch "/:id" do
  MyMemoApp::Memo.new("./memo_data/#{params[:id]}").edit(params[:memo])
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
  @memo_text = MyMemoApp::Memo.new("./memo_data/#{@id}").memo_text_show
  erb :show
end
