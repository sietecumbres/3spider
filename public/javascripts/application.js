$(document).ready(function(){
	$('.box').fancybox();
	$('textarea.editor').ckeditor();
	$('#send-email').live('click', function(){
	  body = $('textarea.editor').val();
	  $.post('/emails', {message_body: body});
	});
});