// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var DEFAULT_WIDTH = "300px";
var DEFAULT_HEIGHT = "300px";

create_note_request = function(event, url) {
   if ($('create_note')) {
     return;
   }
   
   x = Event.pointerX(event) + "px";
   y = Event.pointerY(event) + "px";
   
   params = position_url_params(x, y, DEFAULT_WIDTH, DEFAULT_HEIGHT)
   new Ajax.Request(url, {asynchronous:true, evalScripts:true, method:'get', parameters:params });
   return true;
}

update_position_request = function(url, dom_id) {
    pos = position_values(dom_id);
    url =  url + "?" + position_url_params(pos[0], pos[1], pos[2], pos[3]);
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
    
   content = $('content_' + dom_id);
   content.style.width = (c2[0] - c1[0] - 15) + "px";
   content.style.height = (c2[1] - c1[1] - 45) + "px";
}

coords = function(element) {
	return element.cumulativeOffset().toArray();
}
