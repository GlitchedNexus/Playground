from django.http import HttpResponse, HttpResponseNotAllowed
from django.shortcuts import redirect, render

from .forms import PersonForm


# Create your views here.
def hello_world_view(request):
    return HttpResponse(b"Hello World")


def health_view(request):
    return HttpResponse(b"Backend Online")


def hello_html_view(request):
    return render(request, "todos/hello.html")


def hello_path(request, name):
    return HttpResponse(f"Hello {name}".encode("utf-8"))


def hello_query(request):
    return HttpResponse(f"Your query was: {request.GET.get('q')}".encode("utf-8"))


def special_view(request):
    return redirect("hello_page")


def post_example(request):
    if request.method == "POST":
        form = PersonForm(request.POST)

        if form.is_valid():
            name = form.cleaned_data["name"]
            age = form.cleaned_data["age"]
            job = form.cleaned_data["job"]
            return HttpResponse(f"Your posted: {name}, {age}, {job}".encode("utf-8"))
    else:
        return HttpResponseNotAllowed(["Post"])


def submit_example(request):
    return render(request, "todos/submit.html")


def submit_django_form(request):
    form = PersonForm()
    return render(request, "todos/submit_django_form.html", {"form": form})
