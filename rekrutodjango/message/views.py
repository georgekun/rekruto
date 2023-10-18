from django.shortcuts import render
from django.http import HttpResponse
from .models import Message


def say_hello(request):
    name = request.GET.get("name")
    message = request.GET.get("message")

    if name is not None and message is not None:
        name = name
        message = message
        ip_address = get_client_ip(request) 
        Message.objects.create(name = name, message = message,ip_address= ip_address)
    else:
        name = "Гость"
        message = "Как дела?"
    
    context = {
        'name': name,
        'message': message,
    }

    return render(request, 'index.html', context)



def get_client_ip(request):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip
