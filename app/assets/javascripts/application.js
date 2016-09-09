// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment
//= require turbolinks
//= require_tree .

// 侧栏显示和隐藏事件
$(document).ready(function() {
	$(document).on("click", "#menu-toggle", function(e){
		e.preventDefault();$("#wrapper").toggleClass("toggled");
	});
});

// msg: flash显示的内容；type：flash的类型包括：'alert-success'和'alert-danger'
function show_flash_msg(msg, type) {
  var existFlashs = $('.flash-msg').find("div[style='']");
  if (existFlashs.length > 0) {
    existFlashs.each(function() {
      $(this).remove();
    });
  }
  var flash_msg = $('.flash-msg .alert').clone();
  $('.flash-msg').append(flash_msg);
  flash_msg.append("<p>" + msg + "</p>");
  flash_msg.addClass(type);
  flash_msg.show();
  if (type == "alert-success") {
    setTimeout(function() {
      flash_msg.remove();
    }, 3000);
  } else {
    setTimeout(function() {
      flash_msg.remove();
    }, 7000);
  }
}
