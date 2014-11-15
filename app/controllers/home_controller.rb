class HomeController < ApplicationController
  def index
    @meetings = Meeting.all
  end
end
