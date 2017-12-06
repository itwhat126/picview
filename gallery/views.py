from django.http import Http404, HttpResponse, HttpResponseRedirect, JsonResponse
from django.shortcuts import render, redirect
from django.core.paginator import Paginator
from utils.thumbnail import Thumbnail
from utils.get_bcrypt import get_bcrypt
from gallery.models import HighCategory, Category, Gallery, UploadImg, Client, Comment
from django.views.decorators.http import require_GET,require_POST,require_http_methods
from django.core.urlresolvers import reverse

from PIL import Image, ImageDraw, ImageFont
from django.utils.six import BytesIO

from utils.decorators import login_required

import pprint


def index(request):
	"""首页
	"""
	# pprint.pprint(request.META['HTTP_USER_AGENT'])
	page_num = int(request.GET.get("page") or 1)
	cate_id = int(request.GET.get("sev") or 0)
	keywords = request.GET.get("q")

	data = {}
	# 大类
	data["high_cates"] = HighCategory.objects.all().order_by('order_by')

	# 首页展示相册分页
	gallery_qs = Gallery.objects.filter(
			id__in=UploadImg.objects.values('gallery')).order_by('-create_at')
	if cate_id:
		# 分类展示
		gallery_qs = gallery_qs.filter(category__id=cate_id)
	if keywords:
		# 搜索关键词
		gallery_qs = gallery_qs.search(keywords)

	# 分页器（每页数量为8）
	pager = Paginator(gallery_qs, 12)
	data["cur_page"] = pager.page(page_num)

	return render(request, 'index.html', data)


def img_thumbnail(request, img_id, size=200):
	"""返回图片缩略图
	"""
	try:
		img = UploadImg.objects.get(id=img_id)
	except UploadImg.DoesNotExist:
		raise Http404("Image does not exist")

	thumb_data = Thumbnail(
			image=img.get_local_pathname(), source_type='local',
			width=size, height=size, method='m')

	return HttpResponse(thumb_data, content_type="image/jpeg")


def gallery(request, gallery_id):
	try:
		gallery = Gallery.objects.get(pk=gallery_id)
	except Gallery.DoesNotExist:
		raise Http404("Gallery does not exist")

	return render(request, 'gallery.html', {"gallery": gallery})


def img_detail(request, img_id):
	try:
		img = UploadImg.objects.get(pk=img_id)
	except UploadImg.DoesNotExist:
		raise Http404("Image does not exist")

	return render(request, 'img_detail.html', {"img": img})


def login_view(request):
	return render(request, 'login.html')


@require_POST
def login_check(request):
	"""登陆校验
	"""
	username = request.POST.get('username')
	password = request.POST.get('password')
	remember = request.POST.get('remember')

	if not all([username, password, remember]):
		return JsonResponse({'flag':0})

	try:
		client = Client.objects.get(username=username)
		# print(client.username)
		salt = client.salt
		# 需要获取bcrypt加密后的密码
		old_password = client.password.encode('utf-8')

		b_password = get_bcrypt(password.encode('utf-8'), salt)
		# print('bcrypt加密 %s'%b_password)

		if old_password == b_password:
			Json = JsonResponse({'flag':1})

			request.session['islogin'] = True
			request.session['username'] = username

			if remember == 'true':
				# 记住用户名
				Json.set_cookie('username', username, max_age=7*24*3600)
			else:
				# 不记住用户名/若原来记住后又取消，则删除原来cookie中的该用户名
				Json.delete_cookie('username')
			return Json
		else:
			# 用户名或密码错误
			return JsonResponse({'flag':2})
	except:
		# 匹配不到正确的用户名仍视为用户名错误
		return JsonResponse({'flag':3})


# /verify_code/
def verify_code(request):
	"""生成验证码
	"""
	import random
	# 定义变量，用于画面的背景色、宽、高
	bgcolor = (random.randrange(20, 200), random.randrange(
		20, 100), 255)
	width = 100
	height = 30
	# 创建画面对象
	im = Image.new('RGB', (width, height), bgcolor)
	# 创建画笔对象
	draw = ImageDraw.Draw(im)
	# 调用画笔的point()函数绘制噪点
	for i in range(0, 100):
		xy = (random.randrange(0, width), random.randrange(0, height))
		fill = (random.randrange(0, 255), 255, random.randrange(0, 255))
		draw.point(xy, fill=fill)
	# 定义验证码的备选值
	str1 = 'ABCD123EFGHIJK456LMNOPQRS789TUVWXYZ0'
	# 随机选取4个值作为验证码
	rand_str = ''
	for i in range(0, 4):
		rand_str += str1[random.randrange(0, len(str1))]
	# 构造字体对象，ubuntu的字体路径为“/usr/share/fonts/truetype/freefont”
	font = ImageFont.truetype('FreeMono.ttf', 23)
	# 构造字体颜色
	fontcolor = (255, random.randrange(0, 255), random.randrange(0, 255))
	# 绘制4个字
	draw.text((5, 2), rand_str[0], font=font, fill=fontcolor)
	draw.text((25, 2), rand_str[1], font=font, fill=fontcolor)
	draw.text((50, 2), rand_str[2], font=font, fill=fontcolor)
	draw.text((75, 2), rand_str[3], font=font, fill=fontcolor)
	# 释放画笔
	del draw
	# 存入session，用于做进一步验证
	request.session['verifycode'] = rand_str
	# 内存文件操作
	buf = BytesIO()
	# 将图片保存在内存中，文件类型为png
	im.save(buf, 'png')
	# 将内存中的图片数据返回给客户端，MIME类型为图片png
	return HttpResponse(buf.getvalue(), 'image/png')

@login_required
def logout_view(request):
	request.session.flush()
	return redirect(reverse('gallery:index'))


def register(request):
	return render(request, 'register.html')


@require_POST
def register_handle(request):
	"""注册用户
	"""
	username = request.POST.get('username')
	password_1 = request.POST.get('password1')
	password_2 = request.POST.get('password2')
	phone = request.POST.get('phone')
	vcode = request.POST.get('vcode')
	vcode2 = request.session['verifycode']

	phone_len = len(phone)

	if not all([username, password_1, password_2, phone, vcode]):
		return render(request, 'register.html', {'errmsg':'请输入完整信息'})

	if password_1 == password_2:
		# 如果两次密码相同
		if phone_len == 11:
			if vcode == vcode2:
				b_password, salt = get_bcrypt(password_1.encode('utf-8'))
				obj = Client.objects.add_one(username, b_password, phone, salt)
			else:
				return render(request, 'register.html', {'errmsg':'验证码错误'})
		else:
			return render(request, 'register.html', {'errmsg_phone':'手机号输入非法'})
	else:
		# 两次密码不同
		return render(request, 'register.html', {'errmsg':'两次密码不相同'}) 
	
	return redirect(reverse('gallery:index'))


def username_check(request):
	"""检验用户名是否存在
	"""
	name = request.GET.get('username')
	users = Client.objects.all()

	user_list = []
	for one in users:
		user_list.append(one.username)
		print(one.username)
	if name in user_list:
		return JsonResponse({'flag':0})
	else:
		return JsonResponse({'flag':1})


@login_required
def resetpwd(request):
	return render(request, 'change_pwd.html')


@login_required
def resetpwd_handle(request):
	username = request.session['username']

	password = request.POST.get('old_pwd')
	password_n1 = request.POST.get('new_pwd_1')
	password_n2 = request.POST.get('new_pwd_2')

	if not all([password, password_n1, password_n2]):
		return JsonResponse({'flag':0})

	try:
		client = Client.objects.get(username=username)
		salt = client.salt
		# 需要获取bcrypt加密后的密码
		old_password = client.password.encode('utf-8')
		b_password = get_bcrypt(password.encode('utf-8'), salt)

		if b_password == old_password:
			if password_n1 == password_n2:
				new_password, salt = get_bcrypt(password_n1.encode('utf-8'))
				# 更新用户的password, salt
				obj = Client.objects.update_one(username, new_password, salt)
				return JsonResponse({'flag':4})
			else:
				# 新输入的两次密码不相同
				return JsonResponse({'flag':2})
		else:
			# 密码错误
			return JsonResponse({'flag':1})
	except:
		# 未查寻到用户信息
		return JsonResponse({'flag':3})


def comment(request):
	vcode = request.POST.get('vld_code')
	vcode2 = request.session['verifycode']
	print('vcode---%s'%vcode)
	print('vcode2--%s'%vcode2)

	# if not all([]}):
	# 	return render(request, 'gallery.html', {'errmsg':'信息不能为空'})
	pass