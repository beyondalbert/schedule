class TasksController < ApplicationController

  # before_action :require_login
  
  def index
  	@tasks = current_user.tasks
  end

  def create
  	@task = Task.new(task_params.merge!({user_id: current_user.id}))
    @task.start = task_params[:start] + "+08:00"
    @task.end = task_params[:end] + "+08:00"
  	@task.save!
  	@tasks = current_user.tasks
  	respond_to do |f|
      f.js
  	end
  end

  def gantt
  end

  def gantt_data
    @tasks = current_user.tasks
    @data = []
    @tasks.each do |t|
      if Time.now > t.end
        customClass = "ganttRed"
      elsif Time.now < t.start
        customClass = "ganttGray"
      else
        customClass = "ganttGreen"
      end

      @data << {"name": t.content, "desc": "", "values": 
        [{"id": t.id, "from": "/Date(#{t.start.to_i * 1000})/", "to": "/Date(#{t.end.to_i * 1000})/", 
          "desc": "开始时间： #{t.start}<br>结束时间： #{t.end}", "customClass": customClass, "label": t.content}]}
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
