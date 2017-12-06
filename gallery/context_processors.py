from django.conf import settings


def config(request):
    conf = {"settings": settings}
    return conf
