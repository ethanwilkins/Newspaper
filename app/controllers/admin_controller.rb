class AdminController < ApplicationController
  def index
    @code = Code.new
  end
end
