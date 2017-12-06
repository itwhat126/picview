$(function(){
	$('#id_search_input').focus(function(){
		$(this).attr('placeholder', '')
	})
})

$(function(){
	$('#id_search_input').blur(function(){
		$(this).attr('placeholder', '请输入关键字,以空格分割')
	})		
})