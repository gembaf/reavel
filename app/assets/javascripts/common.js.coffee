
$(document).ready ->
  $("button#add_row").click ->
    $("table tr.hidden").first().toggleClass()

  $("#sortable").sortable({
    placeholder: 'placeholder',
    forceHelperSize: true
  })

  $("#sortable").click ->
    tr = $("#sortable td.serial input")
    $.each tr, (index, elem)->
      elem.value = index+1

