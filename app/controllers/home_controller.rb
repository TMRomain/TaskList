class HomeController < ApplicationController  
  protect_from_forgery with: :null_session
  def index
    @tasks = Task.all
  end
  def addTask
  end

 
end
