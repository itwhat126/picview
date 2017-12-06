from django.contrib import admin
from gallery.models import HighCategory, Category, Gallery, UploadImg, Comment


@admin.register(HighCategory)
class HighCategoryAdmin(admin.ModelAdmin):
    pass


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    pass


@admin.register(Gallery)
class GalleryAdmin(admin.ModelAdmin):
    pass


@admin.register(UploadImg)
class UploadImgAdmin(admin.ModelAdmin):
    list_display = (
        'id', 'title', 'gallery', 'owner', 'size', 'file', 'is_cover')
    list_display_links = ('id', 'title',)
    readonly_fields = ('ext', 'md5', 'size')


@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    pass
