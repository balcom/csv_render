class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.csv { render :csv => "content"}
  end
end