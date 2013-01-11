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
    auto_link(RedCloth.new(note.content).to_html).html_safe
  end
      
  def div_note(note, dom_id, &block)
    content_tag(:div, :id => dom_id, 
                      :class => 'note box', 
                      :style => "left: #{note.pos_x}px; top: #{note.pos_y}px;",
                      &block)
  end
  
  def div_content(note, dom_id, &block)
    content_tag(:div, :id => "content_#{dom_id}", 
                      :class => 'content', 
                      :style => "width: #{note.width}px; height: #{note.height}px;", 
                      &block)    
  end 
  
  def js_update_pos(note)
    "update_position_request('#{js_url(note_path(note))}', '#{dom_id(note)}');"
  end
  
  def js_dblclick_box(dom_id, note, process)
    js_dblclick(dom_id, process ? edit_note_path(note) : nil, process)
  end
    
  def js_draggable(dom_id, on_end, on_change = nil)
    on_change = "change: function(draggable) { #{on_change} }," if on_change 
    js = <<-JS
    new ExtendedDraggable('#{dom_id}', { 
                  scroll: window, 
                  snap: 10, #{on_change}                  
                  onEnd: function() { #{on_end} } } );    
    JS
    js.html_safe
  end
  
  def js_url(url)
    html_escape(escape_javascript(url_for(url)))
  end

  def js_dblclick_board(board)
    js_dblclick(dom_id(board), edit_board_path(board))
  end
  
  def js_dblclick(dom_id, url, process = true)
    js = <<-JS
    Event.observe('#{dom_id}', 
                    'dblclick', 
                    function (event) { 
                      Event.stop(event); 
                      #{remote_function(:url => url, :method => :get) + ";" if process} 
                    }); 
    JS
    js.html_safe
  end
  
end
