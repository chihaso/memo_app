# frozen_string_literal: true

delete "/:id" do
  FileUtils.rm("./memo_data/#{params[:id]}")
  redirect to("/")
end
