# frozen_string_literal: true

get "/new" do
  erb :new
end

post "/" do
  File.open("./memo_data/#{SecureRandom.uuid}", "w", 0o0666) do |file|
    file.puts params[:memo]
  end
  redirect to("/")
end
