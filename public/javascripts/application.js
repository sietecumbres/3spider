$(document).ready(function(){
	$('.box').fancybox({
		hideOnOverlayClick: false,
		overlayColor: '#FFF',
		showCloseButton: false
	});
	
	$('#contact-form').live('submit', function(e){
		e.preventDefault();
		$(this).ajaxSubmit({
			success: function(){
				$.fancybox.close();
				$.jGrowl("¡Gracias por comunicarse con nosotros!. Pronto nos estaremos comunicando de vuelta.", {life: 10000});
			}
		});
	});
	
  $('.cancel').live('click', function(){
    $.fancybox.close();
  });
/*	
	$('.box').fancybox();*/
	$('textarea.editor').ckeditor();
	$('#send-email').live('click', function(){
	  body = $('textarea.editor').val();
	  $.post('/emails', {message_body: body});
	});
});