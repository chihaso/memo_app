# frozen_string_literal: true

get "/:id" do
  @id = params[:id]
  @memo_text = File.read("./memo_data/#{@id}").gsub("\n", "<br>")
  erb :show
end
