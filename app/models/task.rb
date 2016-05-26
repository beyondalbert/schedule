class Task < ActiveRecord::Base
  belongs_to :user

  def status_name
    self.status == 0 ? "未完成" : "已完成"
  end
end
