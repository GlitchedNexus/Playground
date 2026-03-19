from django.http import HttpResponse, HttpResponseNotAllowed
from django.shortcuts import redirect, render

from .forms import PersonForm, TodoForm
from .models import Person, Todo


# Create your views here.
def hello_world_view(request):
    return HttpResponse("Hello World")


def health_view(request):
    return HttpResponse("Backend Online")


def hello_html_view(request):
    return render(request, "todos/hello.html")


def hello_path(request, name):
    return HttpResponse(f"Hello {name}")


def hello_query(request):
    return HttpResponse(f"Your query was: {request.GET.get('q')}")


def special_view(request):
    return redirect("hello_page")


def post_example(request):
    if request.method == "POST":
        form = PersonForm(request.POST)

        if form.is_valid():
            name = form.cleaned_data["name"]
            age = form.cleaned_data["age"]
            return HttpResponse(f"Your posted: {name}, {age}")
    else:
        return HttpResponseNotAllowed(["POST"])


def submit_example(request):
    return render(request, "todos/submit.html")


def submit_django_form(request):
    form = PersonForm()
    return render(request, "todos/submit_django_form.html", {"form": form})


def template_view(request):
    context = {
        "name": "Mike",
        "age": 21,
        "skills": ["Python", "SQL"],
    }

    return render(request, "todos/template_demo.html", context)


def todos_view(request):
    if request.method == "POST":
        form = TodoForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponse("Todo Successfully Created!")

    else:
        form = TodoForm()

        todos = Todo.objects.all()

        return render(request, "todos/todos.html", {"form": form, "todos": todos})
    # else:
    #     return HttpResponseNotAllowed(["POST", "GET"])


def register_view(request):
    if request.method == "POST":
        form = PersonForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponse("Account Successfully Created!")
    else:
        form = TodoForm()

        todos = Todo.objects.all()

        return render(request, "todos/submit.html", {"form": form, "todos": todos})


def person_details(request, person_id):
    person = Person.objects.filter(id=person_id).first()

    return render(request, "todos/person_details.html", {"person": person})


def delete_todo(request, todo_id):
    todo = Todo.objects.filter(id=todo_id).first()
    todo.delete()
    return HttpResponse("Entry successfully deleted from the database.")


def toggle_todo(request, todo_id):
    todo = Todo.objects.filter(id=todo_id).first()
    todo.done = not todo.done
    todo.save()
    return HttpResponse("Request complete.")
