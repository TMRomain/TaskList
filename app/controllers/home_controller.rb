class HomeController < ApplicationController  
  protect_from_forgery with: :null_session

  @@monthIndex = (Time.now).month
  @@currentSelection = "monthly"

  def index
    @current_selected_month = @@monthIndex
    @current_selection = @@currentSelection
    if  @@currentSelection == "monthly"
      @tasks = Task.get_monthly_tasks(@current_selected_month)
    elsif  @@currentSelection == "finished"
      @tasks = Task.get_finished_tasks
    elsif  @@currentSelection == "toCome"
      @tasks = Task.get_to_come_tasks
    elsif  @@currentSelection == "all"
      @tasks = Task.get_all_tasks
    else
      @tasks = Task.get_all_tasks
    end
    # logger.debug(@currentSelection)
  end
  def addTask

  end

  def updateSelection
    @@currentSelection = params[:selection]
    redirect_to '/'
  end

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
    @task  = Task.create_task(task_title,task_description,task_date,task_iscompleted)

    # Save the new task to the database
    @task.save

    # Redirect to the index page after successful creation
    redirect_to '/'
  end

  def updateTask
    task = Task.get_task_by_id(params[:id])
    task.title = params[:title]
    task.desc = params[:description]
    task.date = params[:date]
    task.iscompleted = params[:iscompleted]
    task.save
    redirect_to '/'
  end

  def delete
    task = Task.get_task_by_id(params[:id])
    task.destroy
    redirect_to '/'
  end

  def changeState
    @task = Task.get_task_by_id(params[:id])
    @task.iscompleted = !@task.iscompleted
    @task.save
    # update the page 
    redirect_to '/'
  end

  def redirectToUpdate
    @task = Task.get_task_by_id(params[:id])
    # load view updateTask.html.erb
    render template: "home/updateTask"
  end

  def update
    @task = Task.get_task_by_id(params[:id])
    @task.completed = params[:completed]
    if @task.save
      redirect_to tasks_path
    else
      render :edit
    end
  end
end
