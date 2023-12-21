class HomeController < ApplicationController  
  protect_from_forgery with: :null_session

  @@monthIndex = (Time.now).month
  @@currentSelection = "monthly"

  def index
    @current_selected_month = @@monthIndex
    @current_selection = @@currentSelection

    # Récupération des tâches en fonction de la sélection actuelle
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
    # Exemple d'utilisation du logger pour déboguer
    # logger.debug(@currentSelection)
  end

  # Méthode pour afficher le formulaire d'ajout de tâche
  def addTask
  end

  # Méthode pour mettre à jour la sélection
  def updateSelection
    @@currentSelection = params[:selection]
    redirect_to '/'
  end

  # Méthodes pour naviguer au mois suivant et précédent
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

  # Méthode pour créer une tâche
  def create
    # Vérifie si params[:id] n'est pas nul
    # Si ce n'est pas nul, met à jour la tâche
    # Sinon, crée une nouvelle tâche
    if params[:id] != ""
      updateTask
      return
    end

    task_title = params[:title]
    task_description = params[:description]
    task_date = params[:date]
    task_iscompleted = false
    @task  = Task.create_task(task_title,task_description,task_date,task_iscompleted)

    # Enregistre la nouvelle tâche dans la base de données
    @task.save

    # Redirige vers la page d'accueil après la création réussie
    redirect_to '/'
  end

  # Méthode pour mettre à jour une tâche
  def updateTask
    task = Task.update_task(params[:id],params[:title],params[:description],params[:date],params[:iscompleted])
    redirect_to '/'
  end

  # Méthode pour supprimer une tâche
  def delete
    task = Task.get_task_by_id(params[:id])
    task.destroy
    redirect_to '/'
  end

  # Méthode pour changer l'état d'une tâche (complétée ou non complétée)
  def changeState
    @task = Task.get_task_by_id(params[:id])
    @task.iscompleted = !@task.iscompleted
    @task.save
    # Met à jour la page 
    redirect_to '/'
  end

  # Méthode pour rediriger vers la vue de mise à jour de tâche
  def redirectToUpdate
    @task = Task.get_task_by_id(params[:id])
    # Charge la vue updateTask.html.erb
    render template: "home/updateTask"
  end

  # Méthode pour mettre à jour une tâche
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