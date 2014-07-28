
$(document).ready ->
  $("button#add_row").click ->
    $("table tr.hidden").first().toggleClass()

  $("#fields_for tbody").sortable({
    placeholder: 'placeholder',
    forceHelperSize: true
  })

