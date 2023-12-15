class HomeController < ApplicationController  
  protect_from_forgery with: :null_session
  @@monthIndex = (Time.now).month
  @@currentSelection = "(Time.now).month"
  def index
    @current_selected_month = @@monthIndex
    @tasks = Task.select { |task| task.date.month == @current_selected_month }
    logger.debug(@current_selected_month)
  end
  def addTask

  end
  def currentSelection

  def nextMonth
    @@monthIndex = @@monthIndex + 1
    if @@monthIndex > 12
      @@monthIndex = 1
    end
    redirect_to '/'
  end

  def previousMonth
    @@monthIndex = @@monthIndex - 1
    if @@monthIndex < 1
      @@monthIndex = 12
    end
    redirect_to '/'
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

  def changeState
    @task = Task.find(params[:id])
    @task.iscompleted = !@task.iscompleted
    @task.save
    # update the page 
    redirect_to '/'
  end

  def redirectToUpdate
    @task = Task.find(params[:id])
    # load view updateTask.html.erb
    render template: "home/updateTask"
  end

  def update
    @task = Task.find(params[:id])
    @task.completed = params[:completed]
    if @task.save
      flash[:success] = "Task updated successfully"
      redirect_to tasks_path
    else
      render :edit
    end
  end
end
