$(function(){

	var error_name = false;
	var error_password1 = false;
	var error_password2 = false;
	var error_phone = false;

	// 注册时检验 用户名是否合格
	$("#id_username").blur(function()
	{
		var hint = $("#id_username_hint");
		//hint.empty()
		var name = $("#id_username").val();
		if (name.length < 6) {
			hint.html("请至少填写6个字符");
			hint.show()
		}
		else {
			$.ajax({
				url: '/username_check/?username=' + name,
				type: 'GET',
				dataType: 'json'
			}).success(function (data) {
				if (data.flag == 1) {
					hint.empty();
					hint.show();
					error_name = true;
				}
				else {
					hint.html("该用户名已被注册");
					hint.show();
				}
			})
		}
	})


	$('#verify').focus(function(){
		$(this).attr('placeholder', '')
	})

	$('#verify').blur(function(){
		$(this).attr('placeholder', '点击图片更换验证码')
	})      

	$('#id_password1').blur(function(){
		L1 = $(this).val().length
		if(L1<6||L1>15)
		{
			error_password1 = false;
		}
		else
		{
			error_password1 = true
		}
	})

	$('#id_password2').blur(function(){
		L2 = $(this).val().length
		if(L2<6||L2>15)
		{
			error_password2 = false;
		}
		else
		{
			error_password2 = true
		}
	})

	$('#id_phone').blur(function(){
		Lphone = $(this).val().lengthZ
		if(Lphone == 11){
			error_phone = true;
		}
	})

	$('#id_btn_submit').submit(function(){
		if(error_name == true && error_password1 == true && error_password2 == true && error_phone == true)
		{
			alert('注册成功!');
			return true;
		}
		else
		{
			return false;
		}
	})
})



// $("#id_btn_sms").click(function () { on_btn_sms(); });

// var wait = 61;
// function on_btn_sms() {
//     var btn = $("#id_btn_sms");
//     var phone = $("#id_phone");
//     var cellphone = phone.val();

//     if (wait == 0) {
//         btn.attr("disabled", false);
//         btn.val("发送短信验证码");
//         wait = 61;
//     }
//     else {
//         if (wait == 61) {
//             var x = $.ajax({
//                 url: "/get_vfy_code/?phone=" + cellphone, success: function () {
//                     var phone_hint = $("#id_phone_hint");
//                     //phone_hint.empty();
//                     var response = x.responseText;
//                     if (response == "hurried") {
//                         phone_hint.html("<div class=\"alert alert-danger\">操作过于频繁，请稍后再试！</div>");
//                     }
//                     else if (response == "wrong phone") {
//                         phone_hint.html("<div class=\"alert alert-danger\">错误的手机号码</div>");
//                     }
//                     else if (response == "exist") {
//                         phone_hint.html("<div class=\"alert alert-danger\">该手机号码已被使用</div>");
//                     }
//                     else if (response.length == 32) {
//                         $("#id_vfy_hash").val(response);
//                         phone.attr("readonly", "readonly");
//                     }
//                     else {
//                         phone_hint.html("<div class=\"alert alert-danger\">" + response + "</div>");
//                     }
//                 }
//             });
//         }
//     }

//     btn.attr("disabled", true);
//     btn.val("wait " + wait + "seconds");
//     wait--;
//     setTimeout(function () { on_btn_sms(); }, 100);
// }

