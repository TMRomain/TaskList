class Task < ApplicationRecord
    validates :title, presence: true
    validates :date, presence: true
    def self.get_task_by_id(id)
        find(id)
    end
    def self.get_monthly_tasks(current_selected_month)
        where("extract(month from date) = ?", current_selected_month).order(date: :asc)
    end
    def self.get_finished_tasks
        where("iscompleted = ?", true).order(date: :asc)
    end
    def self.get_to_come_tasks
        where("date >= ?", Date.today.beginning_of_month).order(date: :asc)
    end
    def self.get_all_tasks
        all.order(date: :asc)
    end
    def self.create_task(title,description,date,iscompleted)
        create(title: title, desc: description, date: date, iscompleted: iscompleted)
    end

    def self.update_task(id,title,description,date,iscompleted)
        task = find(id)
        task.title = title
        task.desc = description
        task.date = date
        task.iscompleted = iscompleted
        task.save
    end
    def self.delete_task(id)
        task = find(id)
        task.destroy
    end
    def self.change_state(id)
        task = find(id)
        task.iscompleted = !task.iscompleted
        task.save
    end
  end