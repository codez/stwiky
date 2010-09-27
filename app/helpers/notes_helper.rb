module NotesHelper
  
  def css_position(note)
    "left: #{note.pos_x}px; top: #{note.pos_y}px;"
  end
  
  def js_update_pos(note)
    url = "'" + html_escape(escape_javascript(url_for(pos_note_path(note))))
    url += "?note[pos_x]=' + note.style.left + '&note[pos_y]=' + note.style.top"
    "function() { var note = $('#{dom_id(note)}'); new Ajax.Request(#{url}, {method: 'put'}); }"
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