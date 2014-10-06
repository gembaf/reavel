$("#myModal").html("<%= escape_javascript(
  render partial: 'shared/modal/part', locals: {part: @part}
) %>")
$("#myModal").modal()

