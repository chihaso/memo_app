# frozen_string_literal: true

require "sinatra"
require "sinatra/reloader"
require "fileutils"
require "securerandom"
require "./lib/new.rb"
require "./lib/show.rb"
require "./lib/edit.rb"
require "./lib/delete.rb"

# トップ（index）ページ
get "/" do
  file_names = Dir.glob("./memo_data/*")
  @first_lines = []
  @file_ids =[]
  file_names.each do |fn|
    @first_lines << File.open(fn, "r") { |file| file.gets }
    @file_ids << fn.delete_prefix("./memo_data/")
  end
  erb :top
end
