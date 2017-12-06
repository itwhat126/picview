from django import template
from django.conf import settings

register = template.Library()


@register.filter
def gallery_url(gallery):
    """获取相册的链接地址
    """
    return "/gallery_{}/".format(gallery.id)


@register.filter
def cover_img(gallery):
    """获取相册的封面图
    """
    # 获取封面图，如果没有设置，默认取第一张
    cover_img = gallery.uploadimg_set.filter(is_cover=True).first()
    if cover_img is None:
        cover_img = gallery.uploadimg_set.first()
    return cover_img


@register.filter
def img_thumb_url(img):
    """获取图片的缩略图地址
    """
    return "{}/thumb_{}_200.jpg".format(settings.BASE_URL, img.id)


@register.filter
def img_detail_url(img):
    """获取图片详情页地址
    """
    return "{}/imgdetail_{}/".format(settings.BASE_URL, img.id)
