// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require ace
//= require mode-ruby
//= require theme-twilight

var editor = ace.edit("editor");
var keys = {};
editor.setTheme("ace/theme/twilight");
editor.getSession().setMode("ace/mode/ruby");
document.getElementById('editor').style.fontSize='14px';
$(document).ready(function(){
	    
	compute_result();

	$("#tip").hide();

    $("#send").click(function(){
    	$("#tip").show();
    	compute_result();
    });
	
	$("#editor").keydown(function(key){
		keys[key.which] = true;
		if(keys.hasOwnProperty(13) == true && keys.hasOwnProperty(91) == true) {
			$("#tip").hide();
			compute_result();
		};
    });

    $("#editor").keyup(function(key){
    	delete keys[key.which];
    });
});

function compute_result() {
	code = editor.session.getDocument().getAllLines();
	display_pending();
	$.ajax({
		url: "/editors/evaluate",
		type: "POST",
		data: { "code": code}
	}).done(function(response){
		keys = {};
		print_result(response.result);
	});		    	
}

function display_pending() {
	$("#result").text("處理中...");
}

function print_result(text) {
	$("#result").text(text);
}
