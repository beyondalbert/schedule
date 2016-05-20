module ApplicationHelper
  # 显示flash信息
  # flash[:error] flash[:notice] flash[:success] flash[:warn]
  def render_flash_messages
    s = ''
    flash.each do |k, v|
      info_css = ''
      case k
      when :alert
        info_css = "alert-danger"
      when :notice
        info_css = "alert-info"
      when :success
        info_css = "alert-success"
      when :warning
        info_css = "alert-warning"
      end
      s << content_tag('div', content_tag('button', '&times;'.html_safe, class: "close", 'data-dismiss' => 'alert', 'aria-hidden' => 'true') +  v.html_safe, :class => "alert #{info_css} alert-dismissable", :id => "flash_#{k}")
    end
    s.html_safe
  end
end
