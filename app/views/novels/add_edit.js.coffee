$("#myModal").html("<%= escape_javascript(
  render partial: 'shared/modal/novel', locals: {novel: @novel}
) %>")
$("#myModal").modal()

