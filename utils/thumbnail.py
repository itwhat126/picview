# Filename: thumbnail.py
# Author: Li Ling
# First touch: 2010-12-9

class ThumbnailError(Exception):
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return 'Error: ' + self.value

import requests
import hashlib
import os
import re
from io import StringIO, BytesIO

## 所需常量，可以定义在此处，也可以从其他模块（比如settings）导入

# 指定缓存图片保存路径，这个常量是必需的
try:
    from django.conf import settings
    THUMBNAIL_ROOT = os.path.join(settings.BASE_DIR, 'thumbnails')
except:
    THUMBNAIL_ROOT = "/tmp/_thumbnails"

# 允许的图片所属域，可选，如不定义，则允许任何输入。本例不定义该选项。
THUMBNAIL_ALLOW_DOMAIN_LIST = None
#THUMBNAIL_ALLOW_DOMAIN_LIST = ['192.168.1.11:8080', 'blog.sffan.com.cn', ]

def Thumbnail(image, source_type='url', width = 0, height = 0, method = 'cm', enable_cache = True, flash_cache = False):
    """
    一个生成缩略图的函数，需要安装PIL包。

    返回值：
        JPEG格式的缩略图数据。
    需要在settings.py中定义以下常量：
        THUMBNAIL_ROOT: 必须定义，指定缓存图片的存储路径。
        THUMBNAIL_ALLOW_DOMAIN_LIST: 允许输入的源图片域列表。可选，如不定义，则允许任何域。

    参数说明：
        image: 图片的完整URL地址。
        source_type: 输入图片的类型： url, local
        width: int类型，缩略图的宽，如果为0，则使用源图片宽度。
        height: int类型，缩略图的高，如果为0，则使用源图片高度。
        method: string类型，包含转换参数。参数说明：
            s - 不裁切图像，按指定尺寸拉伸或压缩图像，如果有这个参数，则其他参数都无效。
            c - 按尺寸裁切图像。
            m - 与“c”搭配使用，从图像中部裁切。
            t - 与“c”搭配使用，从图像顶端裁切。
            b - 与“c”搭配使用，从图像底部裁切。
            l - 与“c”搭配使用，从图像左侧裁切。
            r - 与“c”搭配使用，从图像右侧裁切。
        enable_cache: bool类型，指定是否使用缓存图片，默认为True。
        flash_cache: bool类型，指定是否更新缓存，默认为False。
    """
    thumb_path = THUMBNAIL_ROOT

    try:
        from PIL import Image
    except:
        raise ThumbnailError('No module named Image. Make sure PIL package installed.')

    if source_type == 'url':
        if not THUMBNAIL_ALLOW_DOMAIN_LIST == None:
            local_domain = re.split("://", re.match("https?://[^/\\\\]+", image).group())[1]
            if not local_domain in THUMBNAIL_ALLOW_DOMAIN_LIST:
                raise ThumbnailError('Domain ' + local_domain + ' is not in THUMBNAIL_ALLOW_DOMAIN_LIST.')

    raw_str = repr(image) + repr(width) + repr(height) + repr(method)
    md5filename = hashlib.md5(raw_str.encode('utf-8')).hexdigest() + ".jpg"

    if not os.path.exists(thumb_path):
        os.makedirs(thumb_path)

    thumb_pathname = os.path.join(thumb_path, md5filename)
    trumb_exists = os.path.isfile( thumb_pathname )
    # 检查是否有缓存
    if trumb_exists and enable_cache and not flash_cache:
        with open(thumb_pathname, 'rb') as f:
            thumb = f.read()
        return thumb

    # 读取图片数据
    if source_type == 'url':
        try:
            imgReq = requests.get(image)
        except requests.ConnectionError:
            raise ThumbnailError('unknown url: ' + image)
        imgStr = imgReq.content
    elif source_type == 'local':
        with open(image, 'rb') as f:
            imgStr = f.read()

    if width == 0 and height == 0:
        return imgStr

    if method == '':
        method = 'cm'

    imgIO = BytesIO(imgStr)
    imgData = Image.open(imgIO)
    imgData = imgData.convert('RGB')
    imgSrcSize = imgData.size       # 原图片尺寸
    width = int(width)
    height = int(height)
    imgSrcWidth = float(imgSrcSize[0])
    imgSrcHeight = float(imgSrcSize[1])

    if width == 0 or height == 0 or imgSrcWidth/imgSrcHeight == width/height:
        # 等比例缩放
        if width == 0:
            width = int(imgSrcWidth * height / imgSrcHeight)
        else:
            height = int(imgSrcHeight * width / imgSrcWidth)
            imgData = imgData.resize((width, height))
    elif 's' in method:
        # 不裁切图像，按指定尺寸拉伸或压缩图像，如果有s参数，其他参数都无效。
        imgData = imgData.resize((width, height))
    else:
        # 缩放后按尺寸裁切
        if width/height > imgSrcWidth/imgSrcHeight:
            # 需要从上下裁切
            newHeight = int(imgSrcHeight * width/imgSrcWidth)
            imgData = imgData.resize((width, newHeight), Image.ANTIALIAS)
            offset = (newHeight - height) / 2
            if 't' in method:
                # 从顶端裁切
                imgData = imgData.transform((width, height), Image.EXTENT, (0, 0, width, height))
            elif 'b' in method:
                # 从底端裁切
                imgData = imgData.transform((width, height), Image.EXTENT, (0, offset*2, width, height+offset+offset))
            else:
                imgData = imgData.transform((width, height), Image.EXTENT, (0, offset, width, height+offset))
        else:
            # 需要从左右裁切
            newWidth = int(imgSrcWidth * height/imgSrcHeight)
            imgData = imgData.resize((newWidth, height), Image.ANTIALIAS)
            offset = (newWidth - width) / 2
            if 'l' in method:
                imgData = imgData.transform((width, height), Image.EXTENT, (0, 0, width, height))
            elif 'r' in method:
                imgData = imgData.transform((width, height), Image.EXTENT, (offset*2, 0, width+offset+offset, height))
            else:
                imgData = imgData.transform((width, height), Image.EXTENT, (offset, 0, width+offset, height))

    file_out = BytesIO()
    imgData.save(file_out, 'jpeg', quality=100)
    file_out.seek(0)
    fileStr = file_out.read()

    if flash_cache or (enable_cache and not trumb_exists):
        print('>>> Flashing cache...')
        try:
            thumb_cache = open(thumb_pathname, 'wb')
            thumb_cache.write(fileStr)
            thumb_cache.close()
        except IOError:
            raise ThumbnailError('Cannot write to cache file: ' + thumb_path)

    return fileStr
