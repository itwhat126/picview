from django import forms


class LoginForm(forms.Form):
    """登录表单
    """
    input_attrs = {
            'class': "form-control",
            'placeholder': "必填",
            'required': "",
            'autofocus': "",
            'style': "background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP6zwAAAgcBApocMXEAAAAASUVORK5CYII=&quot;);",
        }

    username = forms.CharField(label='用户名', max_length=100,
            widget=forms.TextInput(attrs=input_attrs))
    password = forms.CharField(label='密码', max_length=100,
            widget=forms.PasswordInput(attrs=input_attrs))


class RegisterForm(forms.Form):
    """注册表单
    """
    username_input_attrs = {
            'class': "form-control",
            'placeholder': "至少6位字符的用户名，不可以是纯数字",
            'required': "",
            'autofocus': "",
        }
    # phone_input_attrs = {
    #         'class': "form-control",
    #         'placeholder': "11位数字的手机号码",
    #         'required': "",
    #     }
    password_input_attrs = {
            'class': "form-control",
            'placeholder': "请设置自己的登录密码",
            'required': "",
        }

    username = forms.CharField(label='用户名', max_length=100,
            widget=forms.TextInput(attrs=username_input_attrs))
    # phone = forms.CharField(label='手机号码', max_length=32,
    #         widget=forms.TextInput(attrs=phone_input_attrs))
    password1 = forms.CharField(label='密码', max_length=100,
            widget=forms.PasswordInput(attrs=password_input_attrs))
    password2 = forms.CharField(label='密码', max_length=100,
            widget=forms.PasswordInput(attrs=password_input_attrs))


class ChangePwdForm(forms.Form):
    """修改密码表单
    """
    input_attrs = {
            'class': "form-control",
            'placeholder': "必填",
            'required': "",
            'autofocus': "",
            'style': "background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP6zwAAAgcBApocMXEAAAAASUVORK5CYII=&quot;);",
        }

    old_password = forms.CharField(label='用户名', max_length=100,
            widget=forms.PasswordInput(attrs=input_attrs))
    password1 = forms.CharField(label='密码', max_length=100,
            widget=forms.PasswordInput(attrs=input_attrs))
    password2 = forms.CharField(label='密码', max_length=100,
            widget=forms.PasswordInput(attrs=input_attrs))

