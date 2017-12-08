$(function(){
    $('#id_btn_login').click(function(){
        var username = $('#id_username').val();
        var password = $('#id_password').val();
        var remember = $('input[name="remember"]').prop('checked');

        var csrf = $('input[name="csrfmiddlewaretoken"]').val();
        var data_user = {'username':username, 'password':password, 'csrfmiddlewaretoken':csrf, 'remember':remember};

        $.ajax({
            url:'/login_check/',
            type:'POST',
            data:data_user,
            dataType:'json'
        }).success(function(data){

            if(data.flag==0)
            {
                $('.error_last').html('信息不能为空').show()
            }
            else if(data.flag==1)
            {
                location.href = '/'
            }
            else if(data.flag==2)
            {
                $('.error_last').html('用户名或密码错误').show()
            }
            else
            {
                $('.error_last').html('用户名不存在').show()
            }
        })
    })
})