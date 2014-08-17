
@pink_on = ->
  $('body').attr('id', 'pink')

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

  $("#target-preview").click ->
    converter = new Showdown.converter()
    val = $("#text > textarea").val()
    html = converter.makeHtml(val).replace(/\n\n/g, "<br />").replace(/\n/g, "<br />")
    $("#preview").html(html)

  $("input.select").click ->
    $(this).select()

