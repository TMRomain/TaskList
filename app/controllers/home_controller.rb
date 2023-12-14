class HomeController < ApplicationController  
  protect_from_forgery with: :null_session
  def index
    @tasks = Task.all
  end
  def addTask

  end

  def create
    #check if params[:id is not null]
    #if not null, update the task
    #else create a new task
    if params[:id] != ""
      updateTask
      return
    end

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

  def updateTask
    task = Task.find(params[:id])
    task.title = params[:title]
    task.desc = params[:description]
    task.date = params[:date]
    task.iscompleted = params[:iscompleted]
    task.save
    redirect_to '/'
  end

  def delete
    task = Task.find(params[:id])
    task.destroy
    redirect_to '/'
  end

  def redirectToUpdate
    @task = Task.find(params[:id])
    # cosole.log(@task)
    # load view updateTask.html.erb
    render template: "home/updateTask"
  end
end
