import re
import copy
import json
from django.db import models
from django.db.models.manager import Manager
from django.db.models import Q


class AdvanceQueryset(models.query.QuerySet):
	"""支持全文搜索的queryset
	"""
	def __init__(self, model=None, *argv, **kwargs):
		self.search_fields = []              # 需要搜索的字段
		self.filter_like_fields = []         # 匹配包含关键字的字段
		self.filter_equal_fields = []        # 需完全匹配的字段
		self.search_time_fields = []         # 需要搜索的时间字段

		super(AdvanceQueryset, self).__init__(model, *argv, **kwargs)
		if not model:
			return

		for k in ["filter_like_fields",
				  "filter_equal_fields",
				  "search_time_fields"]:
			setattr(self, k, getattr(model, k, []))
		search_fields = copy.copy(getattr(model, "search_fields", None))
		all_fields = self._get_model_fields(model)
		if search_fields:
			for field_name in search_fields:
				if field_name in all_fields and\
						isinstance(all_fields[field_name], (
							models.TimeField, models.DateField,
							models.DateTimeField,
						)):
					self.search_time_fields.append(field_name)
				else:
					self.search_fields.append(field_name)

	@classmethod
	def _get_model_fields(cls, model):
		"""获取一个model的全部字段信息
		"""
		#self._get_model_fields(self.model.potential.field.related_model)['chosen_time']
		return dict([(f.name, f) for f in model._meta.fields])

	def search(self, keywords):
		"""全文搜索
		"""
		if isinstance(keywords, str):
			# strip()方法用来移除字符串首尾指定字符,默认为空格
			keywords = re.sub(' +', ' ', keywords.strip()).split(' ')
			#  print(keywords)
		if not keywords:
			return self.none()
		if not isinstance(keywords, (list, tuple)):
			raise Exception("search() argument must be `list` or `tuple`")
		search_query = self
		for keyword in keywords:
			if not keyword:
				continue
			filters = Q()
			for field in self.search_fields:
				filters |= Q(**{"%s__icontains" % field: keyword})
			for field in self.search_time_fields:
				filters |= Q(**{"%s__contains" % field: keyword})
			search_query = search_query.filter(filters)
		return search_query.distinct()

	def filter_fuzzy(self, **kwargs):
		"""并列条件查询
		"""
		filter_query = self
		filter_fields = self.filter_like_fields + self.filter_equal_fields
		if not filter_fields:
			raise Exception(
				'`filter_like_fields` and `filter_equal_fields` are empty.')
		for field, value in kwargs.iteritems():
			if field in filter_fields:
				if isinstance(value, (tuple, list)):
					if not value:
						return filter_query.none()
					else:
						filters = Q()
						for item in value:
							if field in self.filter_equal_fields:
								filters |= Q(**{field: item})
							else:
								filters |= Q(**{"%s__icontains" % field: item})
					filter_query = filter_query.filter(filters)
				else:
					if field in self.filter_equal_fields:
						filter_query = filter_query.filter(**{field: value})
					else:
						filter_query = filter_query.filter(**{
										"%s__icontains" % field: value})
		return filter_query


class AdvanceManager(Manager):
	def get_queryset(self):
		return AdvanceQueryset(self.model, using=self._db)

	def search(self, *argv, **kwargs):
		return self.all().search(*argv, **kwargs)

	def filter_fuzzy(self, *argv, **kwargs):
		return self.all().filter_fuzzy(*argv, **kwargs)
