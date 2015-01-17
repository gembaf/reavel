$("#myModal").html("<%= escape_javascript(
  render partial: 'shared/modal/story_file', locals: {story: @story}
) %>")
$("#myModal").modal()

