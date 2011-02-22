$(document).ready(function(){
	$('.fancy-contact').fancybox({
		hideOnOverlayClick: false,
		overlayColor: '#FFF',
		showCloseButton: false
	});
	
	$('#contact-form').live('submit', function(e){
		e.preventDefault();
		$('#wrapper').block({
			message: "<img src='/images/ajax-loader.gif' />",
			overlayCSS: { 
				backgroundColor: '#FFFFFF', 
				opacity: 0.6 
			},
			css:{
				border: '0px solid #FFFFFF'
			}
		});
		$(this).ajaxSubmit({
			success: function(){
				$('#wrapper').unblock();
				$.fancybox.close();
				$.jGrowl("¡Gracias por comunicarse con nosotros!. Pronto nos estaremos comunicando de vuelta.", {life: 10000});
			}
		});
	});
	/*
	$('.cancel').live('click', function(){
		$.fancybox.close();
	});
	*/
	
	$('.box').fancybox();
	$('textarea.editor').ckeditor();
	$('#send-email').live('click', function(){
	  body = $('textarea.editor').val();
	  $.post('/emails', {message_body: body});
	});
});