# frozen_string_literal: true

get "/:id/edit" do
  @id = params[:id]
  @memo_text = File.read("./memo_data/#{@id}")
  erb :edit
end

patch "/:id" do
  File.open("./memo_data/#{params[:id]}", "w") do |file|
    file.puts params[:memo]
  end
  redirect to("/")
end
