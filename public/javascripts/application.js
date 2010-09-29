// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var DEFAULT_WIDTH = "300px";
var DEFAULT_HEIGHT = "300px";

create_note = function(event, url) {
   if ($('create_note')) {
     return;
   }
   
   x = Event.pointerX(event) + "px";
   y = Event.pointerY(event) + "px";
   
   params = position_url_params(x, y, DEFAULT_WIDTH, DEFAULT_HEIGHT)
   new Ajax.Request(url, {asynchronous:true, evalScripts:true, method:'get', parameters:params });
}

set_form_position = function(prefix, x, y, w, h) {
   $(prefix + '_pos_x').value = x;
   $(prefix + '_pos_y').value = y; 
   $(prefix + '_width').value = w;
   $(prefix + '_height').value = h;
}

position_url_params = function(x, y, w, h) {
    return "note[pos_x]=" + x + 
           "&note[pos_y]=" + y + 
           "&note[width]=" + w + 
           "&note[height]=" + h;
}

update_position = function(url, element) {
    note = $(element); 
    url =  url + "?" + position_url_params(note.style.left, note.style.top, 
	                                       note.style.width, note.style.height);
	new Ajax.Request(url, {method: 'put'});
}

resize_note = function(note_element, event) {
   note = $(note_element);
   x1 = note.style.left;
   x1 = x1.substr(0, x1.indexOf("px"));
   y1 = note.style.top;
   y1 = y1.substr(0, y1.indexOf("px"));
   x2 = Event.pointerX(event) - 20;
   y2 = Event.pointerY(event) - 20;
    
   note.style.width = (x2 - x1) + "px";
   note.style.height = (y2 - y1) + "px";
}


