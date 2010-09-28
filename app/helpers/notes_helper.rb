module NotesHelper
  
  def css_position(note)
    "left: #{note.pos_x}px; top: #{note.pos_y}px; width: #{note.width}px;"
  end
  
  def js_update_pos(note)
    url = html_escape(escape_javascript(url_for(pos_note_path(note))))
    "function() { update_position('#{url}', '#{dom_id(note)}'); }"
  end
  
  def js_resize_note(note)
    "function(draggable, event) { resize_note('#{dom_id(note)}', event); }"
  end
  
  def create_form_function
    function = "function(event) { "
    function += "create_form(event, \"#{escape_javascript(render :partial => 'new')}\");"
    function += "}"
    function.html_safe
  end
  
  def update_form_function(note)
    function = "function(event) {"
    function += "update_form('#{dom_id(note)}', \"#{escape_javascript(render :partial => 'edit', :object => note)}\");"
    function += "}"
    function.html_safe
  end
end