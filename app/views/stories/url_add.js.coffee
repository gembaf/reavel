$("#myModal").html("<%= escape_javascript(
  render partial: 'shared/modal/story_url', locals: {story: @story}
) %>")
$("#myModal").modal()

