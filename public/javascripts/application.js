// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

create_form = function(event, form) {
   x = Event.pointerX(event) + "px";
   y = Event.pointerY(event) + "px";

   form_div('create_note', x, y, 200, form);    
}

update_form = function(element, form) {
	x = $(element).style.left;
	y = $(element).style.top;
	w = $(element).style.width;
	
	show = form_div('update_note', x, y, w, form);	
	if (show) {
		// TODO handle note / cancel form
		//$(element).remove();
	}
}

form_div = function(id, x, y, w, form) {
   if ($('create_note') || $('update_note')) {
     return false;
   }
   
   html = "<div id=\"" + id + "\" class=\"note\" style=\"left: " + x + 
          "; top: " + y + "; width: " + w + ";\">";
   html += form;
   html += "</div>";
   
   Element.insert("desktop", { bottom: html });
   set_form_position(x, y, w);
   
   // dragging
   new Draggable(id, {scroll: window, 
                      onEnd: function() { 
					       note = $(id); 
					       set_form_position(note.style.left, note.style.top, note.style.width); } });  
   // TODO: resize			   
   return true;
}

set_form_position = function(x, y, w) {
   $('note_pos_x').value = x;
   $('note_pos_y').value = y; 
   $('note_width').value = w;
}


update_position = function(url, element) {
    note = $(element); 
    url =  url + "?note[pos_x]=" + note.style.left + 
	             "&note[pos_y]=" + note.style.top + 
				 "&note[width]=" + note.style.width;
	new Ajax.Request(url, {method: 'put'});
}

resize_note = function(note_element, event) {
   note = $(note_element);
   x1 = note.style.left;
   x1 = x1.substr(0, x1.indexOf("px"));
   y1 = note.style.top;
   y1 = y1.substr(0, y1.indexOf("px"));
   x2 = Event.pointerX(event);
   y2 = Event.pointerY(event);
    
   note.style.width = (x2 - x1) + "px";
   note.style.height = (y2 - y1) + "px";
}


