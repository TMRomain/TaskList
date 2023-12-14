class HomeController < ApplicationController  
  protect_from_forgery with: :null_session
  def index
    @tasks = Task.all
  end
  def addTask
  end

  def create
    task_title = params[:title]
    task_description = params[:description]
    task_date = params[:date]
    task_iscompleted = false
    @task  = Task.new(title: task_title, desc: task_description, date: task_date)

    # Save the new task to the database
    @task.save

    # Redirect to the index page after successful creation
    redirect_to '/'

  end
end
