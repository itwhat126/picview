from django.conf.urls import url
from . import views


urlpatterns = [
	url(r'^$', views.index, name='index'),

	url(r'^gallery_(?P<gallery_id>\d+)/$', views.gallery),
	url(r'^imgdetail_(?P<img_id>\d+)/$', views.img_detail),

	url(r'^thumb_(?P<img_id>\d+)_(?P<size>\d+).jpg$', views.img_thumbnail),

	url(r'^login/$', views.login_view, name='login'),
	url(r'^login_check/$', views.login_check),
	url(r'^verify_code/$', views.verify_code),

	url(r'^logout/$', views.logout_view),
	url(r'^register/$', views.register),
	url(r'^register_handle/$', views.register_handle),
	url(r'^username_check/$', views.username_check),
	url(r'^resetpwd/$', views.resetpwd),
	url(r'^resetpwd_handle/$', views.resetpwd_handle),
	url(r'^comment/$', views.comment),
]

