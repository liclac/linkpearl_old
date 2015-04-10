module ApplicationHelper
  def markdown(text)
    extensions = {
      space_after_headers: true,  # Don't convert #hashtags to headers
      fenced_code_blocks: true,   # Github-style triple-backtick code blocks
      no_intra_emphasis: true,    # Don't emphasize_stuff_like_this
      autolink: true,             # Try to link URLs automatically
      strikethrough: true,        # Allow ~~nonstandard~~ strikethrough
    }
    
    html_flags = {
      escape_html: true,          # Escape user-submitted HTML tags
      hard_wrap: true,            # Allow natural newlines (without spaces)
      xhtml: true,                # Use xhtml syntax (<br />, etc)
    }
    
    renderer = Redcarpet::Render::HTML.new html_flags
    md = Redcarpet::Markdown.new renderer, extensions
    
    md.render(text).html_safe
  end
end
