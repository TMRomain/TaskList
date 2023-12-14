class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks , :id => false do |t|
      t.primary_key :id
      t.string :title
      t.string :desc
      t.date :taskdate
      t.boolean :iscompleted

      t.timestamps
    end
  end
end
