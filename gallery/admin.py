from django.contrib import admin
from gallery.models import HighCategory, Category, Gallery, UploadImg, Comment


@admin.register(HighCategory)
class HighCategoryAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'order_by')
    list_display_links = ('id', 'name', )
    list_editable = ('order_by', )
    search_fields = ('name',)


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'high_cate', 'order_by')
    list_display_links = ('id', 'name', )
    list_editable = ('order_by', )
    search_fields = ('name',)


@admin.register(Gallery)
class GalleryAdmin(admin.ModelAdmin):
    list_display = ('id', 'title', 'categories', 'owner')
    list_display_links = ('id', 'title', )
    search_fields = ('title',)
    filter_horizontal = ('category',)

    def categories(self, obj):
        return ",".join([str(c) for c in obj.category.all()])


@admin.register(UploadImg)
class UploadImgAdmin(admin.ModelAdmin):
    list_display = (
        'id', 'thumb', 'title', 'gallery', 'owner', 'size', 'file', 'is_cover')
    list_display_links = ('id', 'title',)
    search_fields = ('title',)
    readonly_fields = ('ext', 'md5', 'size')
    list_per_page = 10

    def thumb(self, obj):
        """在列表中显示缩略图
        """
        html = '<img src="{}" width="50" />'.format(obj.get_thumb_url())
        return html
    thumb.allow_tags = True
    thumb.short_description = "缩略图"


@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'gallery', 'summary')
    list_display_links = ('id', 'summary')
    search_fields = ('summary',)

    def summary(self, obj):
        max_show = 20       # 后台列表显示内容长度
        if len(obj.content) > max_show:
            return "{}...".format(obj.content[:max_show])
        return obj.content

    def user(self, obj):
        return obj.author.username
