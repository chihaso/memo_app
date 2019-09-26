# frozen_string_literal: true

module MyMemoApp
  class Memo_list
    def initialize(path)
      @path = path
      @file_paths = file_paths
    end

    def file_paths
      Dir.glob(@path)
    end

    def beginnings
      @file_paths.map { |fp| File.open(fp, "r") { |file| file.gets } }
    end

    def names
      @file_paths.map { |fp| fp.delete_prefix("./memo_data/") }
    end
  end
end
