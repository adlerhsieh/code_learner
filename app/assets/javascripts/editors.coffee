# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
# functions & variables
  editor = ace.edit("editor")
  keys = {}
  editor.setTheme("ace/theme/twilight")
  editor.getSession().setMode("ace/mode/ruby")
  document.getElementById('editor').style.fontSize='14px'

  compute_result = ->
    code = editor.session.getDocument().getAllLines()
    display_pending()
    $.ajax
      url: '/editors/evaluate'
      type: 'POST'
      data: 'code': code
      success: (response) ->
        keys = {}
        print_result response.result

  display_pending = ->
    $("#result").text("處理中...")

  print_result = (text) ->
    $("#result").text(text)

# actions
  compute_result()
  $("#tip").hide()
  $("#send").click ->
    $("#tip").show()
    compute_result()

  $("#editor").keydown (key) ->
    keys[key.which] = true
    if keys.hasOwnProperty(13) == true && keys.hasOwnProperty(91) == true
      $("#tip").hide()
      compute_result()

    $("#editor").keyup (key) ->
    	delete keys[key.which]
