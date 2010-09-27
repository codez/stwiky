// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

create_form = function(event, form) {
   x = Event.pointerX(event) + "px";
   y = Event.pointerY(event) + "px";

   form_div('create_note', x, y, form);    
}

update_form = function(element, form) {
	x = $(element).style.left;
	y = $(element).style.top;
	
	form_div('update_note', x, y, form);	
}

form_div = function(id, x, y, form) {
   if ($('create_note') || $('update_note')) {
     return;
   }
   
   html = "<div id=\"" + id + "\" class=\"note\" style=\"left: " + x + "; top: " + y + ";\">";
   html += form;
   html += "</div>";
   
   Element.insert("desktop", { bottom: html });
   $('note_pos_x').value = x;
   $('note_pos_y').value = y; 
   $('note_width').value = 200;
}
