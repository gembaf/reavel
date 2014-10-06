$("#myModal").html("<%= escape_javascript(
  render partial: 'shared/modal/chapter', locals: {chapter: @chapter}
) %>")
$("#myModal").modal()

