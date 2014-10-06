$("#myModal").html("<%= escape_javascript(
  render partial: 'shared/modal/volume', locals: {volume: @volume}
) %>")
$("#myModal").modal()

