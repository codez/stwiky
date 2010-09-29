module NotesHelper
  
  def css_position(note)
    "left: #{note.pos_x}px; top: #{note.pos_y}px; width: #{note.width}px; height: #{note.height}px;"
  end
  
  def js_update_pos(note)
    url = html_escape(escape_javascript(url_for(pos_note_path(note))))
    "function() { update_position('#{url}', '#{dom_id(note)}'); }"
  end
  
  def js_resize_note(dom_id)
    "function(draggable, event) { resize_note('#{dom_id}', event); }".html_safe
  end
  
  def note_div(note, id = nil, &block)
    content_tag(:div, :id => id || dom_id(note), 
                      :class => 'note', 
                      :style => css_position(note), &block)
  end
  
  def edit_dom_id(note)
    "edit_#{dom_id(note)}"
  end
  
end