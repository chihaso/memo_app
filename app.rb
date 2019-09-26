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
