module NotesHelper
  
  def render_box(note, dom_id, update_position_js, process_dblclick = false, &block)
    render :partial => 'box', 
           :locals => {:note => note, 
                       :dom_id => dom_id,
                       :content => capture(&block),
                       :update_position_js => update_position_js,
                       :process_dblclick => process_dblclick}
  end
  
  def format_content(note)
    auto_link(RedCloth.new(note.content).to_html)
  end
      
  def div_note(note, dom_id, &block)
    content_tag(:div, :id => dom_id, 
                      :class => 'note', 
                      :style => css_position(note), &block)
  end
  
  def div_content(note, dom_id, &block)
    content_tag(:div, :id => "content_#{dom_id}", 
                      :class => 'content', 
                      :style => css_dimension(note), &block)    
  end
  
  def edit_dom_id(note)
    "edit_#{dom_id(note)}"
  end
  
  def css_position(note)
    "left: #{note.pos_x}px; top: #{note.pos_y}px;"
  end
  
  def css_dimension(note)    
    "width: #{note.width}px; height: #{note.height}px;"
  end
  
  def js_update_pos(note)
    "update_position_request('#{js_url(pos_note_path(note))}', '#{dom_id(note)}');"
  end
  
  def js_dblclick_box(dom_id, note, process)
    js = <<-JS
      Event.observe('#{dom_id}', 
                    'dblclick', 
                    function (event) { 
                      Event.stop(event); 
                      #{remote_function(:url => edit_note_path(note), :method => :get) + ";" if process} 
                    }); 
    JS
    js.html_safe
  end
    
  def js_draggable(dom_id, on_end, on_drag = nil)
    on_drag = "onDrag: function(draggable, event) { #{on_drag} }," if on_drag 
    js = <<-JS
    new Draggable('#{dom_id}', { 
                  scroll: window, 
                  snap: 10, #{on_drag}                  
                  onEnd: function() { #{on_end} } } );    
    JS
    js.html_safe
  end
  
  def js_url(url)
    html_escape(escape_javascript(url_for(url)))
  end

end