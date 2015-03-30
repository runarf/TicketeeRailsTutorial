# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(->
  $('a, #add_another_file').click(->
    console.log("adding another file button")
    url = "/files/new?number=" + $('#files input').length
    $.get(url,
      console.log("adding the button to html")
      (data)->
        $('#files').append(data)
    )
  )
)