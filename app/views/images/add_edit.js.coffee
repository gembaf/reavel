$("#myModal").html("<%= escape_javascript(
  render partial: 'shared/modal/image', locals: {image: @image}
) %>")
$("#myModal").modal()

