class TasksController < ApplicationController

  before_action :require_login

  def index
    if params[:q].nil?
      params[:q] = {}
      params[:q][:user_id_eq] = current_user.id
    else
      params[:q] = params[:q].merge!({'user_id_eq' => current_user.id})
    end
    @q = Task.ransack(params[:q])
    @history_tasks = @q.result.where(status: 1)
    @current_tasks = @q.result.where(status: 0).reverse_order
  end

  def create
    @task = Task.new(task_params.merge!({user_id: current_user.id}))
    @task.start = task_params[:start].to_time
    @task.end = task_params[:end].to_time
    @task.save!
    @tasks = current_user.tasks.where(status: 0).reverse_order
    respond_to do |f|
      f.js
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.content = task_params[:content]
    @task.start = task_params[:start].to_time
    @task.end = task_params[:end].to_time
    @task.save!

    @current_tasks = current_user.tasks.where(status: 0).reverse_order
    @history_tasks = current_user.tasks.where(status: 1)
    respond_to do |f|
      f.js
    end
  end

  def destroy
    @task = Task.find params[:id]
    @task.destroy!
    @history_tasks = current_user.tasks.where(status: 1)
    @current_tasks = current_user.tasks.where(status: 0).reverse_order
    respond_to do |f|
      f.js
    end
  end

  def change_status
    @task = Task.find params[:id]
    @task.update!(status: params[:status] == "0" ? 1 : 0)

    @current_tasks = current_user.tasks.where(status: 0).reverse_order
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
                  "desc": "#{t.content}<br>开始时间： #{t.start.localtime.strftime('%F')}<br>结束时间： #{t.end.localtime.strftime('%F')}", "customClass": customClass, "label": t.content}]}
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
