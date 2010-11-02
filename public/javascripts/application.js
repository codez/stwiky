// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var dragging = false;

create_note_request = function(event, url) {
   if ($('create_note')) {
     return;
   }
   
   x = Event.pointerX(event);
   y = Event.pointerY(event);
   
   params = position_url_params(x - 20, y - 20, '', '')
   new Ajax.Request(url, {asynchronous:true, evalScripts:true, method:'get', parameters:params });
   return true;
}

update_position_request = function(url, dom_id) {
	if (!dragging) return;
    pos = position_values(dom_id);
    url =  url + "?silent=true&" + position_url_params(pos[0], pos[1], pos[2], pos[3]);
    new Ajax.Request(url, {method: 'put'});
	return true;
}

position_url_params = function(x, y, w, h) {
    return "note[pos_x]=" + x + 
           "&note[pos_y]=" + y + 
           "&note[width]=" + w + 
           "&note[height]=" + h;
}

update_form_position = function(dom_id, prefix) {
   pos = position_values(dom_id);
   $(prefix + '_pos_x').value = pos[0];
   $(prefix + '_pos_y').value = pos[1]; 
   $(prefix + '_width').value = pos[2];
   $(prefix + '_height').value = pos[3];
}

position_values = function(dom_id) {
   note = new Element.Layout($(dom_id)); 
   content = new Element.Layout($('content_' + dom_id));    
   return new Array(note.get('left'), 
                    note.get('top'), 
                    content.get('width'), 
                    content.get('height'));
}

resize_note = function(dom_id) {
   c1 = coords($(dom_id));
   c2 = coords($('resizer_' + dom_id));
   
   layout = new Element.Layout($('resizer_' + dom_id)); 
    
   content = $('content_' + dom_id);
   content.style.width = layout.get('left') - 9 + "px"; 
   content.style.height = null;
   content.style.minHeight = layout.get('top') - 44 + "px";
}

coords = function(element) {
	return element.cumulativeOffset().toArray();
}

var move_note = function(draggable, droppable, event) { 
	if (draggable.id.indexOf('note_') == 0) {
		noteId = draggable.id.substring(5);
		boardId = droppable.id.substring(6);
		Event.stop(event); 
		dragging = false;
		new Ajax.Request(document.location.href + 
		                 '/notes/' + noteId + 
						 '/move?board_id=' + boardId, 
						 {method: 'post'});
	}
}

var ExtendedDraggable = Class.create(Draggable, {
	initDrag: function($super, event) {
	    if (!Object.isUndefined(Draggable._dragging[this.element]) &&
	      Draggable._dragging[this.element]) return;
	    if (Event.isLeftClick(event)) {
	      if (this.shouldStartDrag(event)) {	  
		    dragging = true;      
	        $super(event);
		  }
		}
    },
	
	shouldStartDrag: function(event) {
		modifier = event.altKey || event.ctrlKey || event.shiftKey;
		
        src = Event.element(event);
        textElements = ".content *";
		textElement = this.element.select(textElements).include(src);
		return modifier || !textElement;
	}
});

