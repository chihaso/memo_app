# frozen_string_literal: true

require "securerandom"

module MyMemoApp
  class NewMemo
    def initialize(path, text)
      @path = path
      @text = text
    end

    def save
      File.open("#{@path}#{SecureRandom.uuid}", "w", 0o0666) do |file|
        file.puts @text
      end
    end
  end
end
