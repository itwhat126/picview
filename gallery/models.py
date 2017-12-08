import os
import hashlib
import datetime
from django.conf import settings
from django.db import models
from django.contrib.auth.models import User
from utils.base_model import AdvanceManager
from utils.get_bcrypt import get_bcrypt


class HighCategory(models.Model):
	"""大类
	"""
	name = models.CharField('大类名称', max_length=40, unique=True)
	order_by = models.IntegerField('排序', default=0)

	class Meta:
		verbose_name = verbose_name_plural = "大类"

	def __str__(self):
		return self.name


class Category(models.Model):
	"""分类
	"""
	high_cate = models.ForeignKey(HighCategory, verbose_name='大类', null=True)
	name = models.CharField('分类名称', max_length=40, unique=True)
	order_by = models.IntegerField('排序', default=0)

	class Meta:
		verbose_name = verbose_name_plural = "分类"

	def __str__(self):
		return '{} - {}'.format(self.high_cate, self.name)


class Gallery(models.Model):
	"""相册
	"""
	title = models.CharField('相册标题', max_length=40)

	# 相册可以属于多个分类
	category = models.ManyToManyField(Category, verbose_name='分类')

	owner = models.ForeignKey(User, verbose_name='创建人', null=True)
	order_by = models.IntegerField('排序', default=0)

	create_at = models.DateTimeField('创建时间', auto_now_add=True)
	modify_at = models.DateTimeField('最近修改时间', auto_now=True)

	objects = AdvanceManager()

	search_fields = ('title', 'category__name')

	class Meta:
		verbose_name = verbose_name_plural = "相册"

	def __str__(self):
		return self.title


class UploadImg(models.Model):
	"""上传图片表
	"""
	def get_file_path(instance, filename):
		now = datetime.datetime.now()
		directory_string_var = 'pics/{}/{}/'.format(now.year, now.month)
		return os.path.join(directory_string_var, filename)

	title = models.CharField('图片标题', max_length=40, null=True)
	gallery = models.ForeignKey(Gallery, verbose_name='所属相册')
	owner = models.ForeignKey(User, verbose_name='上传人', null=True)
	ext = models.CharField('文件类型', max_length=32, null=True, blank=True)
	md5 = models.CharField('MD5', max_length=32, null=True, blank=True)
	size = models.BigIntegerField('文件大小', null=True, blank=True)
	file = models.ImageField('图片文件', upload_to=get_file_path)
	order_by = models.IntegerField('排序', default=0)
	is_cover = models.BooleanField('是否相册封面', default=False)

	create_at = models.DateTimeField('创建时间', auto_now_add=True)
	modify_at = models.DateTimeField('修改时间', auto_now=True)

	class Meta:
		verbose_name = verbose_name_plural = "图片"

	def __str__(self):
		return str(self.file)

	def save(self, *args, **kwargs):
		# 计算文件大小和md5值
		md5 = hashlib.md5()
		size = 0
		for chunk in self.file.chunks():
			md5.update(chunk)
			size += len(chunk)
		self.md5 = md5.hexdigest()
		self.size = size
		# 记录扩展名
		self.ext = self.file.name.split('.')[-1].lower()
		super(UploadImg, self).save(*args, **kwargs)

		# 如果设为封面图，则同时取消同相册其他图片的is_cover属性
		if self.is_cover:
			UploadImg.objects.filter(gallery=self.gallery)\
					.exclude(id=self.id).update(is_cover=False)

	def get_url(self):
		"""获取图片url
		"""
		return "{}{}{}".format(settings.BASE_URL, settings.MEDIA_URL, self)
	
	def get_thumb_url(self, size=200):
		"""获取图片缩略图url
		"""
		return "{}/thumb_{}_200.jpg".format(settings.BASE_URL, self.id)
	
	def get_local_pathname(self):
		"""获取图片本地完整路径
		"""
		return os.path.join(settings.MEDIA_ROOT, str(self.file))


class PassportManager(models.Manager):
	"""Client的模型管理器类"""
	def add_one(self, username, password, phone, salt):
		# 添加一个普通用户
		obj = self.create(username=username,password=password,phone=phone,salt=salt)
		return obj

	def update_one(self, username, password, salt):
		obj = self.filter(username=username).update(password=password, salt=salt)
		return obj


class Client(models.Model):
	"""普通用户
	"""
	username = models.CharField(max_length=20, verbose_name='用户名')
	password = models.CharField(max_length=60, verbose_name='密码')
	phone = models.CharField(max_length=20, verbose_name='电话')
	salt = models.CharField(max_length=29, verbose_name='salt值')
	is_active = models.BooleanField(default=False, verbose_name='激活标志')

	objects = PassportManager()

	class Meta:
		verbose_name = verbose_name_plural = '用户'


class CommentManager(models.Manager):
	"""Comment的模型管理器类"""
	def add_one(self, author, gallery_id, content):
		obj = self.create(author_id=author, gallery_id=gallery_id, content=content)
		return obj


class Comment(models.Model):
	"""评论
	"""
	author = models.ForeignKey(Client, verbose_name='作者')
	gallery = models.ForeignKey(Gallery, verbose_name='评论相册', null=True)
	content = models.TextField('内容')

	create_at = models.DateTimeField('创建时间', auto_now_add=True)
	modify_at = models.DateTimeField('修改时间', auto_now=True)

	objects = CommentManager()

	class Meta:
		verbose_name = verbose_name_plural = "评论"