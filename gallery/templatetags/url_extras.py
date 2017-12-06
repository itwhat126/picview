import urllib
from django import template
from django.http import QueryDict

register = template.Library()


@register.simple_tag
def current_url_with_parameter(request, *url_parameters):
    """向url中追加或修改参数
    """
    qs = dict(request.GET.items())
    new_qs = QueryDict(''.join([str(p) for p in url_parameters])).dict()
    qs.update(new_qs)
    return urllib.parse.urlencode(qs)

