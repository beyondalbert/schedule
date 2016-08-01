class TasksController < ApplicationController

  before_action :require_login

  def index
    @history_tasks = current_user.tasks.where(status: 1)
    @current_tasks = current_user.tasks.where(status: 0)
  end

  def create
    @task = Task.new(task_params.merge!({user_id: current_user.id}))
    @task.start = task_params[:start] + "+08:00"
    @task.end = task_params[:end] + "+08:00"
    @task.save!
    @tasks = current_user.tasks.where(status: 0)
    respond_to do |f|
      f.js
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.content = task_params[:content]
    @task.start = task_params[:start] + "+08:00"
    @task.end = task_params[:end] + "+08:00"
    @task.save!

    @current_tasks = current_user.tasks.where(status: 0)
    @history_tasks = current_user.tasks.where(status: 1)
    respond_to do |f|
      f.js
    end
  end

  def destroy
    @task = Task.find params[:id]
    @task.destroy!
    @tasks = current_user.tasks
    respond_to do |f|
      f.js
    end
  end

  def change_status
    @task = Task.find params[:id]
    @task.update!(status: params[:status] == "0" ? 1 : 0)

    @current_tasks = current_user.tasks.where(status: 0)
    @history_tasks = current_user.tasks.where(status: 1)
  end

  def gantt
  end

  def gantt_data
    @tasks = current_user.tasks.where(status: 0)
    @data = []
    @tasks.each do |t|
      if Time.now > t.end
        if t.status == 1
          customClass = "ganttBlue"
        else
          customClass = "ganttRed"
        end
      elsif Time.now < t.start
        customClass = "ganttGray"
      else
        customClass = "ganttGreen"
      end

      @data << {"name": t.content, "desc": "", "values": 
                [{"id": t.id, "from": "/Date(#{t.start.to_i * 1000})/", "to": "/Date(#{t.end.to_i * 1000})/", 
                  "desc": "开始时间： #{t.start.localtime.strftime('%F %R')}<br>结束时间： #{t.end.localtime.strftime('%F %R')}", "customClass": customClass, "label": t.content}]}
    end
    respond_to do |f|
      f.json {render :json => @data.to_json}
    end
  end

  private
  def task_params
    params.require(:task).permit(:content, :start, :end)
  end
end
