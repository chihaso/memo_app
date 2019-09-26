# frozen_string_literal: true

module MyMemoApp
  class Memo
    def initialize(path)
      @path = path
    end

    def memo_text
      File.read(@path)
    end

    def memo_text_show
      File.read(@path).gsub("\n", "<br>")
    end

    def edit(new_text)
      File.open(@path, "w") { |file| file.puts new_text }
    end
  end
end
